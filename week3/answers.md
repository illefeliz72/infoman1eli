# INFOMAN1 — Week 3 Lab Answers

## Task 1 — Classify Attributes and Identify Weak Entities
**1. Attribute Classifications**
* **Composite Attribute:** `full_name` (used in Owner and Veterinarian).
  * *Reason:* It's made up of multiple sub-fields (`first_name` and `last_name`) that can be separated and handled individually.
* **Multivalued Attribute:** `vaccination_history` (or `vaccinations`).
  * *Reason:* A single pet can have multiple vaccination entries attached to them over time.
* **Derived Attribute:** None listed in the scenario.

## Task 2 — Specify Participation Constraints
1. **Owner – Pet**
   * **Owner side:** Mandatory One (`|--|`) — Every pet must be owned by exactly one owner.
   * **Pet side:** Optional Many (`|--o<`) — An owner doesn't need to have pets registered right away (0 or many).

2. **Pet – Appointment**
   * **Pet side:** Mandatory One (`|--|`) — An appointment has to be linked to exactly one pet.
   * **Appointment side:** Optional Many (`|--o<`) — A pet can have 0 or many appointments logged over time.

3. **Veterinarian – Appointment**
   * **Veterinarian side:** Mandatory One (`|--|`) — Each appointment has to be assigned to exactly one vet.
   * **Appointment side:** Optional Many (`|--o<`) — A vet can run multiple appointments or none at all yet.

4. **Pet – Vaccination Record**
   * **Pet side:** Mandatory One (`|--|`) — A vaccination record only exists if it belongs to a pet.
   * **Vaccination Record side:** Optional Many (`|--o<`) — A pet might have 0, 1, or several vaccination records.

## Task 3 — Build the Logical ERD
[erd_diagram.drawio.png]

## Task 4 — Translate to Relational Schema Notation
* **owners**(__owner_id__, first_name, last_name, phone_number)
* **pets**(__pet_id__, name, species, age, owner_id*)
  * *Note: owner_id references owners(owner_id)*
* **veterinarians**(__vet_id__, first_name, last_name, specialization)
* **appointments**(__appointment_id__, appointment_date, reason, vet_id*, pet_id*)
  * *Note: vet_id references veterinarians(vet_id) and pet_id references pets(pet_id)*
* **vaccination_records**(__pet_id*__, __vaccine_name__, __vaccination_date__)
  * *Note: pet_id references pets(pet_id); forms a composite primary key with vaccine_name and vaccination_date*


## Task 5 — Key Justification & Schema Validation
**1. Primary Key Choice Justifications**
* **`owners` Table (`owner_id`):** I went with an auto-generated surrogate key (`owner_id`) instead of phone numbers or full names. Names aren't unique, and people change phone numbers or share them across families, so a numeric ID guarantees each row stays unique.
* **`pets` Table (`pet_id`):** I used a surrogate key (`pet_id`) because pet names are very common (lots of pets share names like "Luna" or "Max"), and species/age aren't enough to uniquely identify an animal.

**2. Scenario Validation Traceability**
* *"A pet owner, identified by an owner ID, full name (consisting of first name and last name), and phone number..."* → Covered in `owners` with `owner_id`, `first_name`, `last_name`, and `phone_number`.
* *"...every pet must belong to exactly one owner... A pet has a pet ID, name, species, and age."* → Covered in `pets` with `pet_id`, `name`, `species`, `age`, and the `owner_id` foreign key.
* *"Every appointment record tracks an appointment ID, appointment date, and reason for visit, and it must specify exactly one veterinarian and exactly one pet..."* → Covered in `appointments` with foreign keys `vet_id*` and `pet_id*`.
* *"A veterinarian, identified by a vet ID, full name, and specialization..."* → Covered in `veterinarians` with `vet_id`, `first_name`, `last_name`, and `specialization`.
* *"...each pet's vaccination history, consisting of a vaccine name and vaccination date... cannot be uniquely identified or looked up on its own."* → Covered in `vaccination_records` using a composite primary key with `pet_id*`, `vaccine_name`, and `vaccination_date`.

## Self-Check

- [ ] All tasks committed with individual, meaningful commit messages
- [ ] All files placed inside `week3/`
- [ ] This file completed `answers.md`
- [ ] Repository link pasted into Moodle (no files uploaded)

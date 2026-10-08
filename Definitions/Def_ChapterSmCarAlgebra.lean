import Mathlib


/-!
# The CAR algebra of the Standard-Model fermions, on a finite mode set

This module removes one of the honest boundaries recorded for the Standard-Model wave of
`CONSOLIDATED_PLAN.md` (§D6b-SM): *“the Dirac and Yukawa operators are not formalized (they
need the CAR/Grassmann algebra) — only the mixing algebra they rest on is”*.  What was
missing was the algebra itself: a Hilbert space carrying creation and annihilation operators
with the canonical **anticommutation** relations.  That is what is built here, for a finite
set of fermionic modes `Fin n`.

## The construction

The fermionic Fock space over `n` modes is the `2ⁿ`-dimensional occupation-number space

```
FermiFock n = ℓ²( Finset (Fin n) )
```

— one orthonormal basis vector `occ S` for each *occupied set* `S ⊆ {0, …, n-1}`, which is
the Lean rendering of the Grassmann degrees of freedom `ζ_F ∈ Z₂^{D_F}` of §D6b-SM.1.  The
annihilation and creation operators carry the Jordan–Wigner sign `jwSign i S = (-1)^{#{j ∈ S
: j < i}}`, which is exactly what makes them *anti*commute rather than commute:

```
(a_i ψ)(S) = if i ∈ S then 0 else jwSign i S * ψ (insert i S)
(a†_i ψ)(S) = if i ∈ S then jwSign i (S.erase i) * ψ (S.erase i) else 0
```

## What is proved

* `car_annih_creat_self` — `a_i a†_i + a†_i a_i = 1`;
* `car_annih_creat_of_ne`, `car_annih_annih`, `car_creat_creat` — the three vanishing
  anticommutators `{a_i, a†_j} = 0 (i ≠ j)`, `{a_i, a_j} = 0`, `{a†_i, a†_j} = 0`
  (including `a_i² = 0`, `(a†_i)² = 0`: the Pauli principle);
* `inner_creat_left`, `inner_annih_left` — `a†_i` is the adjoint of `a_i`;
* `norm_annih_le`, `norm_creat_le` — both are contractions, so every polynomial in them is
  a bounded operator (this is the technical reason the fermionic sector needs no
  Faris–Lavine analysis of its own once the mode set is finite);
* `occupation_apply` — `a†_i a_i` is the occupation-number operator of mode `i`;
* `fermiBilin` — the second quantization `Σ_{i,j} h_{ij} a†_i a_j` of a one-particle matrix,
  with `fermiBilin_symmetric` (Hermitian `h` gives a symmetric operator) and
  `norm_fermiBilin_le` (the `ℓ¹` bound on its norm);
* `fermiEnergy`, `fermiEnergy_apply`, `fermiEnergy_occ` — the diagonal case: the exact
  **spectrum** `Σ_{i ∈ S} m i` of the free fermionic Hamiltonian on the occupation basis;
* `fermi_mass_gap` — a **gap theorem**: if every mode energy is at least `μ ≥ 0`, then every
  state orthogonal to the Fock vacuum has energy at least `μ`.

## Honest boundary

The mode set is finite: this is the CAR algebra of a *truncated* fermion field, which is
what the Standard-Model chapters need in order to write `h_Dirac` and `h_Yukawa` as
operators (`BookProof.ChapterSmDiracYukawa`).  The continuum CAR algebra over an
infinite-dimensional one-particle space, the Lorentz/spinor structure of `γ⁰γ·D`, and the
ghost/BRST sector are not built here.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.SmCar

open Finset

variable {n : ℕ}

/-! ## 1. The occupation-number Hilbert space -/

/-- **The fermionic Fock space over `n` modes**: the `2ⁿ`-dimensional Hilbert space with one
orthonormal basis vector for each occupied set. -/
abbrev FermiFock (n : ℕ) : Type := EuclideanSpace ℂ (Finset (Fin n))

/-- The occupation basis vector `|S⟩`. -/
noncomputable def occ (S : Finset (Fin n)) : FermiFock n := EuclideanSpace.single S 1

/-- The Fock vacuum `|∅⟩`. -/
noncomputable def vac : FermiFock n := occ ∅









/-- **The Jordan–Wigner sign** `(-1)^{#{j ∈ S : j < i}}`: the sign that makes the operators
below anticommute. -/
def jwSign (i : Fin n) (S : Finset (Fin n)) : ℂ :=
  (-1) ^ (S.filter (fun j => j < i)).card



@[simp] theorem conj_jwSign (i : Fin n) (S : Finset (Fin n)) :
    (starRingEnd ℂ) (jwSign i S) = jwSign i S := by
  simp [jwSign]

@[simp] theorem norm_jwSign (i : Fin n) (S : Finset (Fin n)) : ‖jwSign i S‖ = 1 := by
  simp [jwSign]



/-! ## 2. Annihilation and creation -/

/-- **The annihilation operator** `a_i`. -/
noncomputable def annih (i : Fin n) : FermiFock n →ₗ[ℂ] FermiFock n where
  toFun ψ := WithLp.toLp 2 (fun S => if i ∈ S then 0 else jwSign i S * ψ (insert i S))
  map_add' x y := by ext S; by_cases h : i ∈ S <;> simp [h, mul_add]
  map_smul' c x := by ext S; by_cases h : i ∈ S <;> simp [h, mul_left_comm]

/-- **The creation operator** `a†_i`. -/
noncomputable def creat (i : Fin n) : FermiFock n →ₗ[ℂ] FermiFock n where
  toFun ψ := WithLp.toLp 2
    (fun S => if i ∈ S then jwSign i (S.erase i) * ψ (S.erase i) else 0)
  map_add' x y := by ext S; by_cases h : i ∈ S <;> simp [h, mul_add]
  map_smul' c x := by ext S; by_cases h : i ∈ S <;> simp [h, mul_left_comm]

@[simp] theorem annih_apply (i : Fin n) (ψ : FermiFock n) (S : Finset (Fin n)) :
    (annih i ψ) S = if i ∈ S then 0 else jwSign i S * ψ (insert i S) := rfl

@[simp] theorem creat_apply (i : Fin n) (ψ : FermiFock n) (S : Finset (Fin n)) :
    (creat i ψ) S = if i ∈ S then jwSign i (S.erase i) * ψ (S.erase i) else 0 := rfl

/-! ## 3. The canonical anticommutation relations -/









/-! ## 4. Adjointness and contractivity -/

/-- The involution of occupation sets that adds or removes the mode `i`. -/
def flipOcc (i : Fin n) : Finset (Fin n) ≃ Finset (Fin n) :=
  Function.Involutive.toPerm (fun S => if i ∈ S then S.erase i else insert i S) (by
    intro S
    by_cases h : i ∈ S
    · simp [h, Finset.insert_erase h]
    · simp [h, Finset.erase_insert h])

@[simp] theorem flipOcc_apply (i : Fin n) (S : Finset (Fin n)) :
    flipOcc i S = if i ∈ S then S.erase i else insert i S := rfl









/-! ## 5. Occupation numbers, second quantization, and the spectrum -/



/-- **The second quantization of a one-particle matrix**, in the creation-left /
annihilation-right spelling of the programme's doctrine: `Σ_{i,j} h_{ij} a†_i a_j`. -/
noncomputable def fermiBilin (h : Matrix (Fin n) (Fin n) ℂ) : FermiFock n →ₗ[ℂ] FermiFock n :=
  ∑ i : Fin n, ∑ j : Fin n, h i j • (creat i ∘ₗ annih j)







/-- **The free fermionic Hamiltonian** `Σ_i m_i a†_i a_i` with real mode energies. -/
noncomputable def fermiEnergy (m : Fin n → ℝ) : FermiFock n →ₗ[ℂ] FermiFock n :=
  fermiBilin (Matrix.diagonal fun i => (m i : ℂ))









tions.  That is what is built here, for a finite
set of fermionic modes `Fin n`.

## The construction

The fermionic Fock space over `n` modes is the `2ⁿ`-dimensional occupation-number space

```
FermiFock n = ℓ²( Finset (Fin n) )
```

— one orthonormal basis vector `occ S` for each *occupied set* `S ⊆ {0, …, n-1}`, which is
the Lean rendering of the Grassmann degrees of freedom `ζ_F ∈ Z₂^{D_F}` of §D6b-SM.1.  The
annihilation and creation operators carry the Jordan–Wigner sign `jwSign i S = (-1)^{#{j ∈ S
: j < i}}`, which is exactly what makes them *anti*commute rather than commute:

```
(a_i ψ)(S) = if i ∈ S then 0 else jwSign i S * ψ (insert i S)
(a†_i ψ)(S) = if i ∈ S then jwSign i (S.erase i) * ψ (S.erase i) else 0
```

## What is proved

* `car_annih_creat_self` — `a_i a†_i + a†_i a_i = 1`;
* `car_annih_creat_of_ne`, `car_annih_annih`, `car_creat_creat` — the three vanishing
  anticommutators `{a_i, a†_j} = 0 (i ≠ j)`, `{a_i, a_j} = 0`, `{a†_i, a†_j} = 0`
  (including `a_i² = 0`, `(a†_i)² = 0`: the Pauli principle);
* `inner_creat_left`, `inner_annih_left` — `a†_i` is the adjoint of `a_i`;
* `norm_annih_le`, `norm_creat_le` — both are contractions, so every polynomial in them is
  a bounded operator (this is the technical reason the fermionic sector needs no
  Faris–Lavine analysis of its own once the mode set is finite);
* `occupation_apply` — `a†_i a_i` is the occupation-number operator of mode `i`;
* `fermiBilin` — the second quantization `Σ_{i,j} h_{ij} a†_i a_j` of a one-particle matrix,
  with `fermiBilin_symmetric` (Hermitian `h` gives a symmetric operator) and
  `norm_fermiBilin_le` (the `ℓ¹` bound on its norm);
* `fermiEnergy`, `fermiEnergy_apply`, `fermiEnergy_occ` — the diagonal case: the exact
  **spectrum** `Σ_{i ∈ S} m i` of the free fermionic Hamiltonian on the occupation basis;
* `fermi_mass_gap` — a **gap theorem**: if every mode energy is at least `μ ≥ 0`, then every
  state orthogonal to the Fock vacuum has energy at least `μ`.

## Honest boundary

The mode set is finite: this is the CAR algebra of a *truncated* fermion field, which is
what the Standard-Model chapters need in order to write `h_Dirac` and `h_Yukawa` as
operators (`BookProof.ChapterSmDiracYukawa`).  The continuum CAR algebra over an
infinite-dimensional one-particle space, the Lorentz/spinor structure of `γ⁰γ·D`, and the
ghost/BRST sector are not built here.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.SmCar

open Finset

variable {n : ℕ}

/-! ## 1. The occupation-number Hilbert space -/

/-- **The fermionic Fock space over `n` modes**: the `2ⁿ`-dimensional Hilbert space with one
orthonormal basis vector for each occupied set. -/
abbrev FermiFock (n : ℕ) : Type := EuclideanSpace ℂ (Finset (Fin n))

/-- The occupation basis vector `|S⟩`. -/
noncomputable def occ (S : Finset (Fin n)) : FermiFock n := EuclideanSpace.single S 1

/-- The Fock vacuum `|∅⟩`. -/
noncomputable def vac : FermiFock n := occ ∅

theorem inner_eq_sum (x y : FermiFock n) :
    (inner ℂ x y : ℂ) = ∑ S : Finset (Fin n), (starRingEnd ℂ) (x S) * y S := by
  simp [PiLp.inner_apply, RCLike.inner_apply, mul_comm]

theorem sum_apply_fock (f : Fin n → FermiFock n) (S : Finset (Fin n)) :
    (∑ i : Fin n, f i) S = ∑ i : Fin n, (f i) S := by
  simp [WithLp.ofLp_sum]

theorem smul_apply_fock (c : ℂ) (x : FermiFock n) (S : Finset (Fin n)) :
    (c • x) S = c * x S := rfl

theorem normSq_eq_sum (x : FermiFock n) :
    ‖x‖ ^ 2 = ∑ S : Finset (Fin n), ‖x S‖ ^ 2 := by
  rw [EuclideanSpace.norm_eq, Real.sq_sqrt]
  exact Finset.sum_nonneg fun S _ => by positivity

/-- **The Jordan–Wigner sign** `(-1)^{#{j ∈ S : j < i}}`: the sign that makes the operators
below anticommute. -/
def jwSign (i : Fin n) (S : Finset (Fin n)) : ℂ :=
  (-1) ^ (S.filter (fun j => j < i)).card

theorem jwSign_mul_self (i : Fin n) (S : Finset (Fin n)) : jwSign i S * jwSign i S = 1 := by
  simp [jwSign, ← pow_add, ← two_mul, pow_mul]

@[simp] theorem conj_jwSign (i : Fin n) (S : Finset (Fin n)) :
    (starRingEnd ℂ) (jwSign i S) = jwSign i S := by
  simp [jwSign]

@[simp] theorem norm_jwSign (i : Fin n) (S : Finset (Fin n)) : ‖jwSign i S‖ = 1 := by
  simp [jwSign]

/-- Inserting a new element into `S` flips the Jordan–Wigner sign exactly when the new
element sits to the left of `i`. -/
theorem jwSign_insert {i j : Fin n} {S : Finset (Fin n)} (hj : j ∉ S) :
    jwSign i (insert j S) = (if j < i then -1 else 1) * jwSign i S := by
  by_cases h : j < i
  · have hnot : j ∉ S.filter (fun k => k < i) := fun hmem => hj (Finset.mem_filter.mp hmem).1
    rw [jwSign, jwSign, Finset.filter_insert, if_pos h, Finset.card_insert_of_notMem hnot,
      if_pos h]
    ring
  · rw [jwSign, jwSign, Finset.filter_insert, if_neg h, if_neg h, one_mul]

/-! ## 2. Annihilation and creation -/

/-- **The annihilation operator** `a_i`. -/
noncomputable def annih (i : Fin n) : FermiFock n →ₗ[ℂ] FermiFock n where
  toFun ψ := WithLp.toLp 2 (fun S => if i ∈ S then 0 else jwSign i S * ψ (insert i S))
  map_add' x y := by ext S; by_cases h : i ∈ S <;> simp [h, mul_add]
  map_smul' c x := by ext S; by_cases h : i ∈ S <;> simp [h, mul_left_comm]

/-- **The creation operator** `a†_i`. -/
noncomputable def creat (i : Fin n) : FermiFock n →ₗ[ℂ] FermiFock n where
  toFun ψ := WithLp.toLp 2
    (fun S => if i ∈ S then jwSign i (S.erase i) * ψ (S.erase i) else 0)
  map_add' x y := by ext S; by_cases h : i ∈ S <;> simp [h, mul_add]
  map_smul' c x := by ext S; by_cases h : i ∈ S <;> simp [h, mul_left_comm]

@[simp] theorem annih_apply (i : Fin n) (ψ : FermiFock n) (S : Finset (Fin n)) :
    (annih i ψ) S = if i ∈ S then 0 else jwSign i S * ψ (insert i S) := rfl

@[simp] theorem creat_apply (i : Fin n) (ψ : FermiFock n) (S : Finset (Fin n)) :
    (creat i ψ) S = if i ∈ S then jwSign i (S.erase i) * ψ (S.erase i) else 0 := rfl

/-! ## 3. The canonical anticommutation relations -/

/-- **`{a_i, a†_i} = 1`.** -/
theorem car_annih_creat_self (i : Fin n) :
    annih i ∘ₗ creat i + creat i ∘ₗ annih i = LinearMap.id := by
  refine LinearMap.ext fun ψ => ?_
  ext S
  by_cases h : i ∈ S
  · have h1 : i ∉ S.erase i := Finset.notMem_erase i S
    have h2 : insert i (S.erase i) = S := Finset.insert_erase h
    simp only [LinearMap.add_apply, LinearMap.comp_apply, LinearMap.id_apply,
      PiLp.add_apply, annih_apply, creat_apply, if_pos h, if_neg h1, h2, zero_add]
    rw [← mul_assoc, jwSign_mul_self]
    ring
  · have h1 : i ∈ insert i S := Finset.mem_insert_self i S
    have h2 : (insert i S).erase i = S := Finset.erase_insert h
    simp only [LinearMap.add_apply, LinearMap.comp_apply, LinearMap.id_apply,
      PiLp.add_apply, annih_apply, creat_apply, if_neg h, if_pos h1, h2, add_zero]
    rw [← mul_assoc, jwSign_mul_self]
    ring

/-- **`{a_i, a_j} = 0`** — in particular `a_i² = 0`, the Pauli principle. -/
theorem car_annih_annih (i j : Fin n) :
    annih i ∘ₗ annih j + annih j ∘ₗ annih i = 0 := by
  refine LinearMap.ext fun ψ => ?_
  ext S
  rcases eq_or_ne i j with rfl | hij
  · by_cases h : i ∈ S
    · simp [h]
    · simp [h]
  · by_cases hi : i ∈ S
    · by_cases hj : j ∈ S
      · simp [hi, hj]
      · have h1 : i ∈ insert j S := Finset.mem_insert_of_mem hi
        simp [hi, hj, h1]
    · by_cases hj : j ∈ S
      · have h1 : j ∈ insert i S := Finset.mem_insert_of_mem hj
        simp [hi, hj, h1]
      · have hjS : j ∉ insert i S := by
          simp [Finset.mem_insert, hij.symm, hj]
        have hiS : i ∉ insert j S := by
          simp [Finset.mem_insert, hij, hi]
        have hcomm : insert j (insert i S) = insert i (insert j S) := Finset.insert_comm j i S
        have hsign1 : jwSign j (insert i S) = (if i < j then -1 else 1) * jwSign j S :=
          jwSign_insert hi
        have hsign2 : jwSign i (insert j S) = (if j < i then -1 else 1) * jwSign i S :=
          jwSign_insert hj
        have hlt : ¬ (i < j ∧ j < i) := fun ⟨h1, h2⟩ => absurd (h1.trans h2) (lt_irrefl i)
        have hne : i < j ∨ j < i := lt_or_gt_of_ne hij
        simp only [LinearMap.add_apply, LinearMap.comp_apply, LinearMap.zero_apply,
          PiLp.add_apply, PiLp.zero_apply, annih_apply, if_neg hi, if_neg hj, if_neg hjS,
          if_neg hiS, hsign1, hsign2, hcomm]
        rcases hne with hlt1 | hlt2
        · rw [if_pos hlt1, if_neg (asymm hlt1)]
          ring
        · rw [if_neg (asymm hlt2), if_pos hlt2]
          ring

/-- **`{a†_i, a†_j} = 0`** — in particular `(a†_i)² = 0`. -/
theorem car_creat_creat (i j : Fin n) :
    creat i ∘ₗ creat j + creat j ∘ₗ creat i = 0 := by
  refine LinearMap.ext fun ψ => ?_
  ext S
  rcases eq_or_ne i j with rfl | hij
  · by_cases h : i ∈ S
    · simp [h]
    · simp [h]
  · by_cases hi : i ∈ S
    · by_cases hj : j ∈ S
      · -- both occupied: the two terms cancel
        have hjR : j ∈ S.erase i := Finset.mem_erase.mpr ⟨hij.symm, hj⟩
        have hiR : i ∈ S.erase j := Finset.mem_erase.mpr ⟨hij, hi⟩
        set R : Finset (Fin n) := (S.erase i).erase j with hR
        have hRij : (S.erase j).erase i = R := by
          rw [hR, Finset.erase_right_comm]
        have hjnotR : j ∉ R := by
          rw [hR]; exact Finset.notMem_erase _ _
        have hinotR : i ∉ R := by
          rw [hR, Finset.erase_right_comm]; exact Finset.notMem_erase _ _
        have hSi : S.erase i = insert j R := by
          rw [hR, Finset.insert_erase hjR]
        have hSj : S.erase j = insert i R := by
          rw [← hRij, Finset.insert_erase hiR]
        have hsign1 : jwSign i (S.erase i) = (if j < i then -1 else 1) * jwSign i R := by
          rw [hSi]; exact jwSign_insert hjnotR
        have hsign2 : jwSign j (S.erase j) = (if i < j then -1 else 1) * jwSign j R := by
          rw [hSj]; exact jwSign_insert hinotR
        have hne : i < j ∨ j < i := lt_or_gt_of_ne hij
        simp only [LinearMap.add_apply, LinearMap.comp_apply, LinearMap.zero_apply,
          PiLp.add_apply, PiLp.zero_apply, creat_apply, if_pos hi, if_pos hj, if_pos hjR,
          if_pos hiR, hRij, hsign1, hsign2]
        rcases hne with hlt1 | hlt2
        · rw [if_pos hlt1, if_neg (asymm hlt1)]
          ring
        · rw [if_neg (asymm hlt2), if_pos hlt2]
          ring
      · have hjR : j ∉ S.erase i := fun hmem => hj (Finset.mem_of_mem_erase hmem)
        simp [hi, hj, hjR]
    · by_cases hj : j ∈ S
      · have hiR : i ∉ S.erase j := fun hmem => hi (Finset.mem_of_mem_erase hmem)
        simp [hi, hj, hiR]
      · simp [hi, hj]

/-- **`{a_i, a†_j} = 0` for `i ≠ j`.** -/
theorem car_annih_creat_of_ne {i j : Fin n} (hij : i ≠ j) :
    annih i ∘ₗ creat j + creat j ∘ₗ annih i = 0 := by
  refine LinearMap.ext fun ψ => ?_
  ext S
  by_cases hi : i ∈ S
  · -- the first term vanishes; so does the second, unless `j ∈ S`, and then `i ∈ S.erase j`
    by_cases hj : j ∈ S
    · have hiR : i ∈ S.erase j := Finset.mem_erase.mpr ⟨hij, hi⟩
      simp [hi, hj, hiR]
    · simp [hi, hj]
  · by_cases hj : j ∈ S
    · -- the interesting case: `i ∉ S`, `j ∈ S`
      set R : Finset (Fin n) := S.erase j with hR
      have hjnotR : j ∉ R := Finset.notMem_erase _ _
      have hinotR : i ∉ R := fun hmem => hi (Finset.mem_of_mem_erase hmem)
      have hSR : S = insert j R := (Finset.insert_erase hj).symm
      have hjins : j ∈ insert i S := Finset.mem_insert_of_mem hj
      have hins : (insert i S).erase j = insert i R := by
        rw [hSR, Finset.insert_comm, Finset.erase_insert]
        simpa [Finset.mem_insert, hij.symm] using fun h => hjnotR h
      have hsign1 : jwSign i S = (if j < i then -1 else 1) * jwSign i R := by
        rw [hSR]; exact jwSign_insert hjnotR
      have hsign2 : jwSign j (insert i R) = (if i < j then -1 else 1) * jwSign j R :=
        jwSign_insert hinotR
      have hne : i < j ∨ j < i := lt_or_gt_of_ne hij
      simp only [LinearMap.add_apply, LinearMap.comp_apply, LinearMap.zero_apply,
        PiLp.add_apply, PiLp.zero_apply, annih_apply, creat_apply, if_neg hi, if_pos hj,
        if_pos hjins, hins, if_neg hinotR, hsign1, hsign2, ← hR]
      rcases hne with hlt1 | hlt2
      · rw [if_pos hlt1, if_neg (asymm hlt1)]
        ring
      · rw [if_neg (asymm hlt2), if_pos hlt2]
        ring
    · have hjins : j ∉ insert i S := by
        simp [Finset.mem_insert, hij.symm, hj]
      simp [hi, hj, hjins]

/-! ## 4. Adjointness and contractivity -/

/-- The involution of occupation sets that adds or removes the mode `i`. -/
def flipOcc (i : Fin n) : Finset (Fin n) ≃ Finset (Fin n) :=
  Function.Involutive.toPerm (fun S => if i ∈ S then S.erase i else insert i S) (by
    intro S
    by_cases h : i ∈ S
    · simp [h, Finset.insert_erase h]
    · simp [h, Finset.erase_insert h])

@[simp] theorem flipOcc_apply (i : Fin n) (S : Finset (Fin n)) :
    flipOcc i S = if i ∈ S then S.erase i else insert i S := rfl

/-- **`a†_i` is the adjoint of `a_i`.** -/
theorem inner_creat_left (i : Fin n) (ψ φ : FermiFock n) :
    (inner ℂ (creat i ψ) φ : ℂ) = inner ℂ ψ (annih i φ) := by
  rw [inner_eq_sum, inner_eq_sum]
  rw [← Equiv.sum_comp (flipOcc i)
    (fun R => (starRingEnd ℂ) (ψ R) * (annih i φ) R)]
  refine Finset.sum_congr rfl fun S _ => ?_
  by_cases h : i ∈ S
  · have h1 : i ∉ S.erase i := Finset.notMem_erase i S
    have h2 : insert i (S.erase i) = S := Finset.insert_erase h
    simp only [creat_apply, annih_apply, flipOcc_apply, if_pos h, if_neg h1, h2, map_mul,
      conj_jwSign]
    ring
  · have h1 : i ∈ insert i S := Finset.mem_insert_self i S
    simp only [creat_apply, annih_apply, flipOcc_apply, if_neg h, if_pos h1, map_zero,
      zero_mul, mul_zero]

/-- **`a_i` is the adjoint of `a†_i`.** -/
theorem inner_annih_left (i : Fin n) (ψ φ : FermiFock n) :
    (inner ℂ (annih i ψ) φ : ℂ) = inner ℂ ψ (creat i φ) := by
  have h := inner_creat_left i φ ψ
  have h2 := congrArg (starRingEnd ℂ) h
  rw [inner_conj_symm, inner_conj_symm] at h2
  exact h2.symm

/-- The annihilation operator is a contraction. -/
theorem norm_annih_le (i : Fin n) (ψ : FermiFock n) : ‖annih i ψ‖ ≤ ‖ψ‖ := by
  have hsq : ‖annih i ψ‖ ^ 2 ≤ ‖ψ‖ ^ 2 := by
    rw [normSq_eq_sum, normSq_eq_sum]
    have hkey : ∑ S : Finset (Fin n), ‖(annih i ψ) S‖ ^ 2
        = ∑ S : Finset (Fin n), (if i ∈ S then ‖ψ S‖ ^ 2 else 0) := by
      rw [← Equiv.sum_comp (flipOcc i) (fun S => ‖(annih i ψ) S‖ ^ 2)]
      refine Finset.sum_congr rfl fun S _ => ?_
      by_cases h : i ∈ S
      · have h1 : i ∉ S.erase i := Finset.notMem_erase i S
        have h2 : insert i (S.erase i) = S := Finset.insert_erase h
        simp [h, h1, h2]
      · simp [h]
    rw [hkey]
    refine Finset.sum_le_sum fun S _ => ?_
    by_cases h : i ∈ S <;> simp [h]
  have h1 : (0:ℝ) ≤ ‖annih i ψ‖ := norm_nonneg _
  nlinarith [norm_nonneg ψ]

/-- The creation operator is a contraction. -/
theorem norm_creat_le (i : Fin n) (ψ : FermiFock n) : ‖creat i ψ‖ ≤ ‖ψ‖ := by
  have hsq : ‖creat i ψ‖ ^ 2 ≤ ‖ψ‖ ^ 2 := by
    rw [normSq_eq_sum, normSq_eq_sum]
    have hkey : ∑ S : Finset (Fin n), ‖(creat i ψ) S‖ ^ 2
        = ∑ S : Finset (Fin n), (if i ∈ S then 0 else ‖ψ S‖ ^ 2) := by
      rw [← Equiv.sum_comp (flipOcc i) (fun S => ‖(creat i ψ) S‖ ^ 2)]
      refine Finset.sum_congr rfl fun S _ => ?_
      by_cases h : i ∈ S
      · have h1 : i ∉ S.erase i := Finset.notMem_erase i S
        simp [h, h1]
      · have h1 : i ∈ insert i S := Finset.mem_insert_self i S
        have h2 : (insert i S).erase i = S := Finset.erase_insert h
        simp [h, h1, h2]
    rw [hkey]
    refine Finset.sum_le_sum fun S _ => ?_
    by_cases h : i ∈ S <;> simp [h]
  have h1 : (0:ℝ) ≤ ‖creat i ψ‖ := norm_nonneg _
  nlinarith [norm_nonneg ψ]

/-! ## 5. Occupation numbers, second quantization, and the spectrum -/

/-- **The occupation-number operator** `a†_i a_i` reads off whether the mode `i` is
occupied. -/
theorem occupation_apply (i : Fin n) (ψ : FermiFock n) (S : Finset (Fin n)) :
    (creat i (annih i ψ)) S = if i ∈ S then ψ S else 0 := by
  by_cases h : i ∈ S
  · have h1 : i ∉ S.erase i := Finset.notMem_erase i S
    have h2 : insert i (S.erase i) = S := Finset.insert_erase h
    simp only [creat_apply, annih_apply, if_pos h, if_neg h1, h2]
    rw [← mul_assoc, jwSign_mul_self, one_mul]
  · simp [h]

/-- **The second quantization of a one-particle matrix**, in the creation-left /
annihilation-right spelling of the programme's doctrine: `Σ_{i,j} h_{ij} a†_i a_j`. -/
noncomputable def fermiBilin (h : Matrix (Fin n) (Fin n) ℂ) : FermiFock n →ₗ[ℂ] FermiFock n :=
  ∑ i : Fin n, ∑ j : Fin n, h i j • (creat i ∘ₗ annih j)

theorem fermiBilin_apply (h : Matrix (Fin n) (Fin n) ℂ) (ψ : FermiFock n) :
    fermiBilin h ψ = ∑ i : Fin n, ∑ j : Fin n, h i j • creat i (annih j ψ) := by
  simp [fermiBilin, LinearMap.sum_apply]

/-- **A Hermitian one-particle matrix gives a symmetric fermionic operator.** -/
theorem fermiBilin_symmetric {h : Matrix (Fin n) (Fin n) ℂ} (hh : h.conjTranspose = h)
    (ψ φ : FermiFock n) :
    (inner ℂ (fermiBilin h ψ) φ : ℂ) = inner ℂ ψ (fermiBilin h φ) := by
  have hentry : ∀ i j, (starRingEnd ℂ) (h j i) = h i j := by
    intro i j
    have := congrFun (congrFun hh i) j
    simpa [Matrix.conjTranspose_apply] using this
  rw [fermiBilin_apply, fermiBilin_apply]
  rw [sum_inner]
  simp only [sum_inner, inner_smul_left, inner_sum, inner_smul_right]
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
  rw [inner_creat_left, inner_annih_left]
  rw [hentry i j]

/-- The `ℓ¹` bound on the norm of a second-quantized one-particle matrix. -/
theorem norm_fermiBilin_le (h : Matrix (Fin n) (Fin n) ℂ) (ψ : FermiFock n) :
    ‖fermiBilin h ψ‖ ≤ (∑ i : Fin n, ∑ j : Fin n, ‖h i j‖) * ‖ψ‖ := by
  rw [fermiBilin_apply]
  refine le_trans (norm_sum_le _ _) ?_
  rw [Finset.sum_mul]
  refine Finset.sum_le_sum fun i _ => ?_
  refine le_trans (norm_sum_le _ _) ?_
  rw [Finset.sum_mul]
  refine Finset.sum_le_sum fun j _ => ?_
  rw [norm_smul]
  refine mul_le_mul_of_nonneg_left ?_ (norm_nonneg _)
  exact le_trans (norm_creat_le i _) (norm_annih_le j ψ)

/-- **The free fermionic Hamiltonian** `Σ_i m_i a†_i a_i` with real mode energies. -/
noncomputable def fermiEnergy (m : Fin n → ℝ) : FermiFock n →ₗ[ℂ] FermiFock n :=
  fermiBilin (Matrix.diagonal fun i => (m i : ℂ))

/-- The diagonal case of the second quantization is the sum of the occupation-number
operators weighted by the mode energies. -/
theorem fermiEnergy_eq_sum (m : Fin n → ℝ) (ψ : FermiFock n) :
    fermiEnergy m ψ = ∑ i : Fin n, (m i : ℂ) • creat i (annih i ψ) := by
  rw [fermiEnergy, fermiBilin_apply]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [Finset.sum_eq_single i]
  · rw [Matrix.diagonal_apply_eq]
  · intro b _ hb
    rw [Matrix.diagonal_apply_ne _ (Ne.symm hb), zero_smul]
  · intro hi
    exact absurd (Finset.mem_univ i) hi

/-- **The free fermionic Hamiltonian is diagonal in the occupation basis**, with eigenvalue
the sum of the energies of the occupied modes. -/
theorem fermiEnergy_apply (m : Fin n → ℝ) (ψ : FermiFock n) (S : Finset (Fin n)) :
    (fermiEnergy m ψ) S = ((∑ i ∈ S, m i : ℝ) : ℂ) * ψ S := by
  rw [fermiEnergy_eq_sum]
  have hsum : (∑ i : Fin n, (m i : ℂ) • creat i (annih i ψ)) S
      = ∑ i : Fin n, ((m i : ℂ) * (if i ∈ S then ψ S else 0)) := by
    rw [sum_apply_fock]
    exact Finset.sum_congr rfl fun i _ => by
      rw [smul_apply_fock, occupation_apply]
  rw [hsum]
  rw [Finset.sum_congr rfl (fun i (_ : i ∈ Finset.univ) =>
    show (m i : ℂ) * (if i ∈ S then ψ S else 0)
      = (if i ∈ S then (m i : ℂ) else 0) * ψ S by split <;> ring)]
  rw [← Finset.sum_mul]
  congr 1
  rw [Finset.sum_ite_mem, Finset.univ_inter, Complex.ofReal_sum]

/-- The occupation basis diagonalizes the free fermionic Hamiltonian: **its spectrum** is
the set of sums of mode energies. -/
theorem fermiEnergy_occ (m : Fin n → ℝ) (S : Finset (Fin n)) :
    fermiEnergy m (occ S) = ((∑ i ∈ S, m i : ℝ) : ℂ) • occ S := by
  ext T
  rw [fermiEnergy_apply]
  by_cases h : T = S
  · subst h; simp [occ]
  · simp [occ, EuclideanSpace.single_apply, h]

/-- The expectation of the free fermionic Hamiltonian. -/
theorem fermiEnergy_quadForm (m : Fin n → ℝ) (ψ : FermiFock n) :
    (inner ℂ ψ (fermiEnergy m ψ) : ℂ)
      = ∑ S : Finset (Fin n), ((∑ i ∈ S, m i : ℝ) : ℂ) * ((‖ψ S‖ ^ 2 : ℝ) : ℂ) := by
  rw [inner_eq_sum]
  refine Finset.sum_congr rfl fun S _ => ?_
  rw [fermiEnergy_apply]
  rw [show (starRingEnd ℂ) (ψ S) * (((∑ i ∈ S, m i : ℝ) : ℂ) * ψ S)
      = ((∑ i ∈ S, m i : ℝ) : ℂ) * ((starRingEnd ℂ) (ψ S) * ψ S) by ring]
  congr 1
  rw [← Complex.normSq_eq_conj_mul_self]
  simp [Complex.normSq_eq_norm_sq]

/-- **The fermionic mass gap.**  If every mode energy is at least `μ ≥ 0`, then every state
with no Fock-vacuum component has energy at least `μ`: the one-particle mass floor lifts to
a spectral gap above the vacuum of the truncated fermionic sector. -/
theorem fermi_mass_gap {m : Fin n → ℝ} {mu : ℝ} (hmu : 0 ≤ mu) (hm : ∀ i, mu ≤ m i)
    (ψ : FermiFock n) (hvac : ψ ∅ = 0) :
    mu * ‖ψ‖ ^ 2 ≤ (inner ℂ ψ (fermiEnergy m ψ) : ℂ).re := by
  have hre : (inner ℂ ψ (fermiEnergy m ψ) : ℂ).re
      = ∑ S : Finset (Fin n), (∑ i ∈ S, m i) * ‖ψ S‖ ^ 2 := by
    rw [fermiEnergy_quadForm]
    rw [Complex.re_sum]
    refine Finset.sum_congr rfl fun S _ => ?_
    rw [← Complex.ofReal_mul, Complex.ofReal_re]
  rw [hre, normSq_eq_sum, Finset.mul_sum]
  refine Finset.sum_le_sum fun S _ => ?_
  rcases eq_or_ne S ∅ with rfl | hS
  · simp [hvac That is what is built here, for a finite
set of fermionic modes `Fin n`.

## The construction

The fermionic Fock space over `n` modes is the `2ⁿ`-dimensional occupation-number space

```
FermiFock n = ℓ²( Finset (Fin n) )
```

— one orthonormal basis vector `occ S` for each *occupied set* `S ⊆ {0, …, n-1}`, which is
the Lean rendering of the Grassmann degrees of freedom `ζ_F ∈ Z₂^{D_F}` of §D6b-SM.1.  The
annihilation and creation operators carry the Jordan–Wigner sign `jwSign i S = (-1)^{#{j ∈ S
: j < i}}`, which is exactly what makes them *anti*commute rather than commute:

```
(a_i ψ)(S) = if i ∈ S then 0 else jwSign i S * ψ (insert i S)
(a†_i ψ)(S) = if i ∈ S then jwSign i (S.erase i) * ψ (S.erase i) else 0
```

## What is proved

* `car_annih_creat_self` — `a_i a†_i + a†_i a_i = 1`;
* `car_annih_creat_of_ne`, `car_annih_annih`, `car_creat_creat` — the three vanishing
  anticommutators `{a_i, a†_j} = 0 (i ≠ j)`, `{a_i, a_j} = 0`, `{a†_i, a†_j} = 0`
  (including `a_i² = 0`, `(a†_i)² = 0`: the Pauli principle);
* `inner_creat_left`, `inner_annih_left` — `a†_i` is the adjoint of `a_i`;
* `norm_annih_le`, `norm_creat_le` — both are contractions, so every polynomial in them is
  a bounded operator (this is the technical reason the fermionic sector needs no
  Faris–Lavine analysis of its own once the mode set is finite);
* `occupation_apply` — `a†_i a_i` is the occupation-number operator of mode `i`;
* `fermiBilin` — the second quantization `Σ_{i,j} h_{ij} a†_i a_j` of a one-particle matrix,
  with `fermiBilin_symmetric` (Hermitian `h` gives a symmetric operator) and
  `norm_fermiBilin_le` (the `ℓ¹` bound on its norm);
* `fermiEnergy`, `fermiEnergy_apply`, `fermiEnergy_occ` — the diagonal case: the exact
  **spectrum** `Σ_{i ∈ S} m i` of the free fermionic Hamiltonian on the occupation basis;
* `fermi_mass_gap` — a **gap theorem**: if every mode energy is at least `μ ≥ 0`, then every
  state orthogonal to the Fock vacuum has energy at least `μ`.

## Honest boundary

The mode set is finite: this is the CAR algebra of a *truncated* fermion field, which is
what the Standard-Model chapters need in order to write `h_Dirac` and `h_Yukawa` as
operators (`BookProof.ChapterSmDiracYukawa`).  The continuum CAR algebra over an
infinite-dimensional one-particle space, the Lorentz/spinor structure of `γ⁰γ·D`, and the
ghost/BRST sector are not built here.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.SmCar

open Finset

variable {n : ℕ}

/-! ## 1. The occupation-number Hilbert space -/

/-- **The fermionic Fock space over `n` modes**: the `2ⁿ`-dimensional Hilbert space with one
orthonormal basis vector for each occupied set. -/
abbrev FermiFock (n : ℕ) : Type := EuclideanSpace ℂ (Finset (Fin n))

/-- The occupation basis vector `|S⟩`. -/
noncomputable def occ (S : Finset (Fin n)) : FermiFock n := EuclideanSpace.single S 1

/-- The Fock vacuum `|∅⟩`. -/
noncomputable def vac : FermiFock n := occ ∅

theorem inner_eq_sum (x y : FermiFock n) :
    (inner ℂ x y : ℂ) = ∑ S : Finset (Fin n), (starRingEnd ℂ) (x S) * y S := by
  simp [PiLp.inner_apply, RCLike.inner_apply, mul_comm]

theorem sum_apply_fock (f : Fin n → FermiFock n) (S : Finset (Fin n)) :
    (∑ i : Fin n, f i) S = ∑ i : Fin n, (f i) S := by
  simp [WithLp.ofLp_sum]

theorem smul_apply_fock (c : ℂ) (x : FermiFock n) (S : Finset (Fin n)) :
    (c • x) S = c * x S := rfl

theorem normSq_eq_sum (x : FermiFock n) :
    ‖x‖ ^ 2 = ∑ S : Finset (Fin n), ‖x S‖ ^ 2 := by
  rw [EuclideanSpace.norm_eq, Real.sq_sqrt]
  exact Finset.sum_nonneg fun S _ => by positivity

/-- **The Jordan–Wigner sign** `(-1)^{#{j ∈ S : j < i}}`: the sign that makes the operators
below anticommute. -/
def jwSign (i : Fin n) (S : Finset (Fin n)) : ℂ :=
  (-1) ^ (S.filter (fun j => j < i)).card

theorem jwSign_mul_self (i : Fin n) (S : Finset (Fin n)) : jwSign i S * jwSign i S = 1 := by
  simp [jwSign, ← pow_add, ← two_mul, pow_mul]

@[simp] theorem conj_jwSign (i : Fin n) (S : Finset (Fin n)) :
    (starRingEnd ℂ) (jwSign i S) = jwSign i S := by
  simp [jwSign]

@[simp] theorem norm_jwSign (i : Fin n) (S : Finset (Fin n)) : ‖jwSign i S‖ = 1 := by
  simp [jwSign]

/-- Inserting a new element into `S` flips the Jordan–Wigner sign exactly when the new
element sits to the left of `i`. -/
theorem jwSign_insert {i j : Fin n} {S : Finset (Fin n)} (hj : j ∉ S) :
    jwSign i (insert j S) = (if j < i then -1 else 1) * jwSign i S := by
  by_cases h : j < i
  · have hnot : j ∉ S.filter (fun k => k < i) := fun hmem => hj (Finset.mem_filter.mp hmem).1
    rw [jwSign, jwSign, Finset.filter_insert, if_pos h, Finset.card_insert_of_notMem hnot,
      if_pos h]
    ring
  · rw [jwSign, jwSign, Finset.filter_insert, if_neg h, if_neg h, one_mul]

/-! ## 2. Annihilation and creation -/

/-- **The annihilation operator** `a_i`. -/
noncomputable def annih (i : Fin n) : FermiFock n →ₗ[ℂ] FermiFock n where
  toFun ψ := WithLp.toLp 2 (fun S => if i ∈ S then 0 else jwSign i S * ψ (insert i S))
  map_add' x y := by ext S; by_cases h : i ∈ S <;> simp [h, mul_add]
  map_smul' c x := by ext S; by_cases h : i ∈ S <;> simp [h, mul_left_comm]

/-- **The creation operator** `a†_i`. -/
noncomputable def creat (i : Fin n) : FermiFock n →ₗ[ℂ] FermiFock n where
  toFun ψ := WithLp.toLp 2
    (fun S => if i ∈ S then jwSign i (S.erase i) * ψ (S.erase i) else 0)
  map_add' x y := by ext S; by_cases h : i ∈ S <;> simp [h, mul_add]
  map_smul' c x := by ext S; by_cases h : i ∈ S <;> simp [h, mul_left_comm]

@[simp] theorem annih_apply (i : Fin n) (ψ : FermiFock n) (S : Finset (Fin n)) :
    (annih i ψ) S = if i ∈ S then 0 else jwSign i S * ψ (insert i S) := rfl

@[simp] theorem creat_apply (i : Fin n) (ψ : FermiFock n) (S : Finset (Fin n)) :
    (creat i ψ) S = if i ∈ S then jwSign i (S.erase i) * ψ (S.erase i) else 0 := rfl

/-! ## 3. The canonical anticommutation relations -/

/-- **`{a_i, a†_i} = 1`.** -/
theorem car_annih_creat_self (i : Fin n) :
    annih i ∘ₗ creat i + creat i ∘ₗ annih i = LinearMap.id := by
  refine LinearMap.ext fun ψ => ?_
  ext S
  by_cases h : i ∈ S
  · have h1 : i ∉ S.erase i := Finset.notMem_erase i S
    have h2 : insert i (S.erase i) = S := Finset.insert_erase h
    simp only [LinearMap.add_apply, LinearMap.comp_apply, LinearMap.id_apply,
      PiLp.add_apply, annih_apply, creat_apply, if_pos h, if_neg h1, h2, zero_add]
    rw [← mul_assoc, jwSign_mul_self]
    ring
  · have h1 : i ∈ insert i S := Finset.mem_insert_self i S
    have h2 : (insert i S).erase i = S := Finset.erase_insert h
    simp only [LinearMap.add_apply, LinearMap.comp_apply, LinearMap.id_apply,
      PiLp.add_apply, annih_apply, creat_apply, if_neg h, if_pos h1, h2, add_zero]
    rw [← mul_assoc, jwSign_mul_self]
    ring

/-- **`{a_i, a_j} = 0`** — in particular `a_i² = 0`, the Pauli principle. -/
theorem car_annih_annih (i j : Fin n) :
    annih i ∘ₗ annih j + annih j ∘ₗ annih i = 0 := by
  refine LinearMap.ext fun ψ => ?_
  ext S
  rcases eq_or_ne i j with rfl | hij
  · by_cases h : i ∈ S
    · simp [h]
    · simp [h]
  · by_cases hi : i ∈ S
    · by_cases hj : j ∈ S
      · simp [hi, hj]
      · have h1 : i ∈ insert j S := Finset.mem_insert_of_mem hi
        simp [hi, hj, h1]
    · by_cases hj : j ∈ S
      · have h1 : j ∈ insert i S := Finset.mem_insert_of_mem hj
        simp [hi, hj, h1]
      · have hjS : j ∉ insert i S := by
          simp [Finset.mem_insert, hij.symm, hj]
        have hiS : i ∉ insert j S := by
          simp [Finset.mem_insert, hij, hi]
        have hcomm : insert j (insert i S) = insert i (insert j S) := Finset.insert_comm j i S
        have hsign1 : jwSign j (insert i S) = (if i < j then -1 else 1) * jwSign j S :=
          jwSign_insert hi
        have hsign2 : jwSign i (insert j S) = (if j < i then -1 else 1) * jwSign i S :=
          jwSign_insert hj
        have hlt : ¬ (i < j ∧ j < i) := fun ⟨h1, h2⟩ => absurd (h1.trans h2) (lt_irrefl i)
        have hne : i < j ∨ j < i := lt_or_gt_of_ne hij
        simp only [LinearMap.add_apply, LinearMap.comp_apply, LinearMap.zero_apply,
          PiLp.add_apply, PiLp.zero_apply, annih_apply, if_neg hi, if_neg hj, if_neg hjS,
          if_neg hiS, hsign1, hsign2, hcomm]
        rcases hne with hlt1 | hlt2
        · rw [if_pos hlt1, if_neg (asymm hlt1)]
          ring
        · rw [if_neg (asymm hlt2), if_pos hlt2]
          ring

/-- **`{a†_i, a†_j} = 0`** — in particular `(a†_i)² = 0`. -/
theorem car_creat_creat (i j : Fin n) :
    creat i ∘ₗ creat j + creat j ∘ₗ creat i = 0 := by
  refine LinearMap.ext fun ψ => ?_
  ext S
  rcases eq_or_ne i j with rfl | hij
  · by_cases h : i ∈ S
    · simp [h]
    · simp [h]
  · by_cases hi : i ∈ S
    · by_cases hj : j ∈ S
      · -- both occupied: the two terms cancel
        have hjR : j ∈ S.erase i := Finset.mem_erase.mpr ⟨hij.symm, hj⟩
        have hiR : i ∈ S.erase j := Finset.mem_erase.mpr ⟨hij, hi⟩
        set R : Finset (Fin n) := (S.erase i).erase j with hR
        have hRij : (S.erase j).erase i = R := by
          rw [hR, Finset.erase_right_comm]
        have hjnotR : j ∉ R := by
          rw [hR]; exact Finset.notMem_erase _ _
        have hinotR : i ∉ R := by
          rw [hR, Finset.erase_right_comm]; exact Finset.notMem_erase _ _
        have hSi : S.erase i = insert j R := by
          rw [hR, Finset.insert_erase hjR]
        have hSj : S.erase j = insert i R := by
          rw [← hRij, Finset.insert_erase hiR]
        have hsign1 : jwSign i (S.erase i) = (if j < i then -1 else 1) * jwSign i R := by
          rw [hSi]; exact jwSign_insert hjnotR
        have hsign2 : jwSign j (S.erase j) = (if i < j then -1 else 1) * jwSign j R := by
          rw [hSj]; exact jwSign_insert hinotR
        have hne : i < j ∨ j < i := lt_or_gt_of_ne hij
        simp only [LinearMap.add_apply, LinearMap.comp_apply, LinearMap.zero_apply,
          PiLp.add_apply, PiLp.zero_apply, creat_apply, if_pos hi, if_pos hj, if_pos hjR,
          if_pos hiR, hRij, hsign1, hsign2]
        rcases hne with hlt1 | hlt2
        · rw [if_pos hlt1, if_neg (asymm hlt1)]
          ring
        · rw [if_neg (asymm hlt2), if_pos hlt2]
          ring
      · have hjR : j ∉ S.erase i := fun hmem => hj (Finset.mem_of_mem_erase hmem)
        simp [hi, hj, hjR]
    · by_cases hj : j ∈ S
      · have hiR : i ∉ S.erase j := fun hmem => hi (Finset.mem_of_mem_erase hmem)
        simp [hi, hj, hiR]
      · simp [hi, hj]

/-- **`{a_i, a†_j} = 0` for `i ≠ j`.** -/
theorem car_annih_creat_of_ne {i j : Fin n} (hij : i ≠ j) :
    annih i ∘ₗ creat j + creat j ∘ₗ annih i = 0 := by
  refine LinearMap.ext fun ψ => ?_
  ext S
  by_cases hi : i ∈ S
  · -- the first term vanishes; so does the second, unless `j ∈ S`, and then `i ∈ S.erase j`
    by_cases hj : j ∈ S
    · have hiR : i ∈ S.erase j := Finset.mem_erase.mpr ⟨hij, hi⟩
      simp [hi, hj, hiR]
    · simp [hi, hj]
  · by_cases hj : j ∈ S
    · -- the interesting case: `i ∉ S`, `j ∈ S`
      set R : Finset (Fin n) := S.erase j with hR
      have hjnotR : j ∉ R := Finset.notMem_erase _ _
      have hinotR : i ∉ R := fun hmem => hi (Finset.mem_of_mem_erase hmem)
      have hSR : S = insert j R := (Finset.insert_erase hj).symm
      have hjins : j ∈ insert i S := Finset.mem_insert_of_mem hj
      have hins : (insert i S).erase j = insert i R := by
        rw [hSR, Finset.insert_comm, Finset.erase_insert]
        simpa [Finset.mem_insert, hij.symm] using fun h => hjnotR h
      have hsign1 : jwSign i S = (if j < i then -1 else 1) * jwSign i R := by
        rw [hSR]; exact jwSign_insert hjnotR
      have hsign2 : jwSign j (insert i R) = (if i < j then -1 else 1) * jwSign j R :=
        jwSign_insert hinotR
      have hne : i < j ∨ j < i := lt_or_gt_of_ne hij
      simp only [LinearMap.add_apply, LinearMap.comp_apply, LinearMap.zero_apply,
        PiLp.add_apply, PiLp.zero_apply, annih_apply, creat_apply, if_neg hi, if_pos hj,
        if_pos hjins, hins, if_neg hinotR, hsign1, hsign2, ← hR]
      rcases hne with hlt1 | hlt2
      · rw [if_pos hlt1, if_neg (asymm hlt1)]
        ring
      · rw [if_neg (asymm hlt2), if_pos hlt2]
        ring
    · have hjins : j ∉ insert i S := by
        simp [Finset.mem_insert, hij.symm, hj]
      simp [hi, hj, hjins]

/-! ## 4. Adjointness and contractivity -/

/-- The involution of occupation sets that adds or removes the mode `i`. -/
def flipOcc (i : Fin n) : Finset (Fin n) ≃ Finset (Fin n) :=
  Function.Involutive.toPerm (fun S => if i ∈ S then S.erase i else insert i S) (by
    intro S
    by_cases h : i ∈ S
    · simp [h, Finset.insert_erase h]
    · simp [h, Finset.erase_insert h])

@[simp] theorem flipOcc_apply (i : Fin n) (S : Finset (Fin n)) :
    flipOcc i S = if i ∈ S then S.erase i else insert i S := rfl

/-- **`a†_i` is the adjoint of `a_i`.** -/
theorem inner_creat_left (i : Fin n) (ψ φ : FermiFock n) :
    (inner ℂ (creat i ψ) φ : ℂ) = inner ℂ ψ (annih i φ) := by
  rw [inner_eq_sum, inner_eq_sum]
  rw [← Equiv.sum_comp (flipOcc i)
    (fun R => (starRingEnd ℂ) (ψ R) * (annih i φ) R)]
  refine Finset.sum_congr rfl fun S _ => ?_
  by_cases h : i ∈ S
  · have h1 : i ∉ S.erase i := Finset.notMem_erase i S
    have h2 : insert i (S.erase i) = S := Finset.insert_erase h
    simp only [creat_apply, annih_apply, flipOcc_apply, if_pos h, if_neg h1, h2, map_mul,
      conj_jwSign]
    ring
  · have h1 : i ∈ insert i S := Finset.mem_insert_self i S
    simp only [creat_apply, annih_apply, flipOcc_apply, if_neg h, if_pos h1, map_zero,
      zero_mul, mul_zero]

/-- **`a_i` is the adjoint of `a†_i`.** -/
theorem inner_annih_left (i : Fin n) (ψ φ : FermiFock n) :
    (inner ℂ (annih i ψ) φ : ℂ) = inner ℂ ψ (creat i φ) := by
  have h := inner_creat_left i φ ψ
  have h2 := congrArg (starRingEnd ℂ) h
  rw [inner_conj_symm, inner_conj_symm] at h2
  exact h2.symm

/-- The annihilation operator is a contraction. -/
theorem norm_annih_le (i : Fin n) (ψ : FermiFock n) : ‖annih i ψ‖ ≤ ‖ψ‖ := by
  have hsq : ‖annih i ψ‖ ^ 2 ≤ ‖ψ‖ ^ 2 := by
    rw [normSq_eq_sum, normSq_eq_sum]
    have hkey : ∑ S : Finset (Fin n), ‖(annih i ψ) S‖ ^ 2
        = ∑ S : Finset (Fin n), (if i ∈ S then ‖ψ S‖ ^ 2 else 0) := by
      rw [← Equiv.sum_comp (flipOcc i) (fun S => ‖(annih i ψ) S‖ ^ 2)]
      refine Finset.sum_congr rfl fun S _ => ?_
      by_cases h : i ∈ S
      · have h1 : i ∉ S.erase i := Finset.notMem_erase i S
        have h2 : insert i (S.erase i) = S := Finset.insert_erase h
        simp [h, h1, h2]
      · simp [h]
    rw [hkey]
    refine Finset.sum_le_sum fun S _ => ?_
    by_cases h : i ∈ S <;> simp [h]
  have h1 : (0:ℝ) ≤ ‖annih i ψ‖ := norm_nonneg _
  nlinarith [norm_nonneg ψ]

/-- The creation operator is a contraction. -/
theorem norm_creat_le (i : Fin n) (ψ : FermiFock n) : ‖creat i ψ‖ ≤ ‖ψ‖ := by
  have hsq : ‖creat i ψ‖ ^ 2 ≤ ‖ψ‖ ^ 2 := by
    rw [normSq_eq_sum, normSq_eq_sum]
    have hkey : ∑ S : Finset (Fin n), ‖(creat i ψ) S‖ ^ 2
        = ∑ S : Finset (Fin n), (if i ∈ S then 0 else ‖ψ S‖ ^ 2) := by
      rw [← Equiv.sum_comp (flipOcc i) (fun S => ‖(creat i ψ) S‖ ^ 2)]
      refine Finset.sum_congr rfl fun S _ => ?_
      by_cases h : i ∈ S
      · have h1 : i ∉ S.erase i := Finset.notMem_erase i S
        simp [h, h1]
      · have h1 : i ∈ insert i S := Finset.mem_insert_self i S
        have h2 : (insert i S).erase i = S := Finset.erase_insert h
        simp [h, h1, h2]
    rw [hkey]
    refine Finset.sum_le_sum fun S _ => ?_
    by_cases h : i ∈ S <;> simp [h]
  have h1 : (0:ℝ) ≤ ‖creat i ψ‖ := norm_nonneg _
  nlinarith [norm_nonneg ψ]

/-! ## 5. Occupation numbers, second quantization, and the spectrum -/

/-- **The occupation-number operator** `a†_i a_i` reads off whether the mode `i` is
occupied. -/
theorem occupation_apply (i : Fin n) (ψ : FermiFock n) (S : Finset (Fin n)) :
    (creat i (annih i ψ)) S = if i ∈ S then ψ S else 0 := by
  by_cases h : i ∈ S
  · have h1 : i ∉ S.erase i := Finset.notMem_erase i S
    have h2 : insert i (S.erase i) = S := Finset.insert_erase h
    simp only [creat_apply, annih_apply, if_pos h, if_neg h1, h2]
    rw [← mul_assoc, jwSign_mul_self, one_mul]
  · simp [h]

/-- **The second quantization of a one-particle matrix**, in the creation-left /
annihilation-right spelling of the programme's doctrine: `Σ_{i,j} h_{ij} a†_i a_j`. -/
noncomputable def fermiBilin (h : Matrix (Fin n) (Fin n) ℂ) : FermiFock n →ₗ[ℂ] FermiFock n :=
  ∑ i : Fin n, ∑ j : Fin n, h i j • (creat i ∘ₗ annih j)

theorem fermiBilin_apply (h : Matrix (Fin n) (Fin n) ℂ) (ψ : FermiFock n) :
    fermiBilin h ψ = ∑ i : Fin n, ∑ j : Fin n, h i j • creat i (annih j ψ) := by
  simp [fermiBilin, LinearMap.sum_apply]

/-- **A Hermitian one-particle matrix gives a symmetric fermionic operator.** -/
theorem fermiBilin_symmetric {h : Matrix (Fin n) (Fin n) ℂ} (hh : h.conjTranspose = h)
    (ψ φ : FermiFock n) :
    (inner ℂ (fermiBilin h ψ) φ : ℂ) = inner ℂ ψ (fermiBilin h φ) := by
  have hentry : ∀ i j, (starRingEnd ℂ) (h j i) = h i j := by
    intro i j
    have := congrFun (congrFun hh i) j
    simpa [Matrix.conjTranspose_apply] using this
  rw [fermiBilin_apply, fermiBilin_apply]
  rw [sum_inner]
  simp only [sum_inner, inner_smul_left, inner_sum, inner_smul_right]
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
  rw [inner_creat_left, inner_annih_left]
  rw [hentry i j]

/-- The `ℓ¹` bound on the norm of a second-quantized one-particle matrix. -/
theorem norm_fermiBilin_le (h : Matrix (Fin n) (Fin n) ℂ) (ψ : FermiFock n) :
    ‖fermiBilin h ψ‖ ≤ (∑ i : Fin n, ∑ j : Fin n, ‖h i j‖) * ‖ψ‖ := by
  rw [fermiBilin_apply]
  refine le_trans (norm_sum_le _ _) ?_
  rw [Finset.sum_mul]
  refine Finset.sum_le_sum fun i _ => ?_
  refine le_trans (norm_sum_le _ _) ?_
  rw [Finset.sum_mul]
  refine Finset.sum_le_sum fun j _ => ?_
  rw [norm_smul]
  refine mul_le_mul_of_nonneg_left ?_ (norm_nonneg _)
  exact le_trans (norm_creat_le i _) (norm_annih_le j ψ)

/-- **The free fermionic Hamiltonian** `Σ_i m_i a†_i a_i` with real mode energies. -/
noncomputable def fermiEnergy (m : Fin n → ℝ) : FermiFock n →ₗ[ℂ] FermiFock n :=
  fermiBilin (Matrix.diagonal fun i => (m i : ℂ))

/-- The diagonal case of the second quantization is the sum of the occupation-number
operators weighted by the mode energies. -/
theorem fermiEnergy_eq_sum (m : Fin n → ℝ) (ψ : FermiFock n) :
    fermiEnergy m ψ = ∑ i : Fin n, (m i : ℂ) • creat i (annih i ψ) := by
  rw [fermiEnergy, fermiBilin_apply]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [Finset.sum_eq_single i]
  · rw [Matrix.diagonal_apply_eq]
  · intro b _ hb
    rw [Matrix.diagonal_apply_ne _ (Ne.symm hb), zero_smul]
  · intro hi
    exact absurd (Finset.mem_univ i) hi

/-- **The free fermionic Hamiltonian is diagonal in the occupation basis**, with eigenvalue
the sum of the energies of the occupied modes. -/
theorem fermiEnergy_apply (m : Fin n → ℝ) (ψ : FermiFock n) (S : Finset (Fin n)) :
    (fermiEnergy m ψ) S = ((∑ i ∈ S, m i : ℝ) : ℂ) * ψ S := by
  rw [fermiEnergy_eq_sum]
  have hsum : (∑ i : Fin n, (m i : ℂ) • creat i (annih i ψ)) S
      = ∑ i : Fin n, ((m i : ℂ) * (if i ∈ S then ψ S else 0)) := by
    rw [sum_apply_fock]
    exact Finset.sum_congr rfl fun i _ => by
      rw [smul_apply_fock, occupation_apply]
  rw [hsum]
  rw [Finset.sum_congr rfl (fun i (_ : i ∈ Finset.univ) =>
    show (m i : ℂ) * (if i ∈ S then ψ S else 0)
      = (if i ∈ S then (m i : ℂ) else 0) * ψ S by split <;> ring)]
  rw [← Finset.sum_mul]
  congr 1
  rw [Finset.sum_ite_mem, Finset.univ_inter, Complex.ofReal_sum]

/-- The occupation basis diagonalizes the free fermionic Hamiltonian: **its spectrum** is
the set of sums of mode energies. -/
theorem fermiEnergy_occ (m : Fin n → ℝ) (S : Finset (Fin n)) :
    fermiEnergy m (occ S) = ((∑ i ∈ S, m i : ℝ) : ℂ) • occ S := by
  ext T
  rw [fermiEnergy_apply]
  by_cases h : T = S
  · subst h; simp [occ]
  · simp [occ, EuclideanSpace.single_apply, h]

/-- The expectation of the free fermionic Hamiltonian. -/
theorem fermiEnergy_quadForm (m : Fin n → ℝ) (ψ : FermiFock n) :
    (inner ℂ ψ (fermiEnergy m ψ) : ℂ)
      = ∑ S : Finset (Fin n), ((∑ i ∈ S, m i : ℝ) : ℂ) * ((‖ψ S‖ ^ 2 : ℝ) : ℂ) := by
  rw [inner_eq_sum]
  refine Finset.sum_congr rfl fun S _ => ?_
  rw [fermiEnergy_apply]
  rw [show (starRingEnd ℂ) (ψ S) * (((∑ i ∈ S, m i : ℝ) : ℂ) * ψ S)
      = ((∑ i ∈ S, m i : ℝ) : ℂ) * ((starRingEnd ℂ) (ψ S) * ψ S) by ring]
  congr 1
  rw [← Complex.normSq_eq_conj_mul_self]
  simp [Complex.normSq_eq_norm_sq]

/-- **The fermionic mass gap.**  If every mode energy is at least `μ ≥ 0`, then every state
with no Fock-vacuum component has energy at least `μ`: the one-particle mass floor lifts to
a spectral gap above the vacuum of the truncated fermionic sector. -/
theorem fermi_mass_gap {m : Fin n → ℝ} {mu : ℝ} (hmu : 0 ≤ mu) (hm : ∀ i, mu ≤ m i)
    (ψ : FermiFock n) (hvac : ψ ∅ = 0) :
    mu * ‖ψ‖ ^ 2 ≤ (inner ℂ ψ (fermiEnergy m ψ) : ℂ).re := by
  have hre : (inner ℂ ψ (fermiEnergy m ψ) : ℂ).re
      = ∑ S : Finset (Fin n), (∑ i ∈ S, m i) * ‖ψ S‖ ^ 2 := by
    rw [fermiEnergy_quadForm]
    rw [Complex.re_sum]
    refine Finset.sum_congr rfl fun S _ => ?_
    rw [← Complex.ofReal_mul, Complex.ofReal_re]
  rw [hre, normSq_eq_sum, Finset.mul_sum]
  refine Finset.sum_le_sum fun S _ => ?_
  rcases eq_or_ne S ∅ with rfl | hS
  · simp [hvac]
  · have hne : S.Nonempty := Finset.nonempty_of_ne_empty hS
    obtain ⟨i0, hi0⟩ := hne
    have hge : mu ≤ ∑ i ∈ S, m i := by
      have hsum : ∑ i ∈ S, mu ≤ ∑ i ∈ S, m i :=
        Finset.sum_le_sum fun i _ => hm i
      have hcard : (S.card : ℝ) * mu ≤ ∑ i ∈ S, m i := by
        simpa [Finset.sum_const, nsmul_eq_mul] using hsum
      have h1 : (1:ℝ) ≤ (S.card : ℝ) := by
        exact_mod_cast Finset.card_pos.mpr ⟨i0, hi0⟩
      nlinarith
    have hnn : (0:ℝ) ≤ ‖ψ S‖ ^ 2 := by positivity
    exact mul_le_mul_of_nonneg_right hge hnn

/-! ## 6. Two worked values, to pin the conventions -/

/-- `a_0 |{0}⟩ = |∅⟩`. -/
theorem annih_occ_single : (annih (0 : Fin 2) (occ {0})) ∅ = 1 := by
  simp [occ, annih, jwSign, EuclideanSpace.single_apply]

/-- `a_1 |{0,1}⟩ = -|{0}⟩`: the Jordan–Wigner sign is genuinely there, and it is what makes
the operators anticommute. -/
theorem annih_occ_sign : (annih (1 : Fin 2) (occ {0, 1})) {0} = -1 := by
  have h1 : ({1, 0} : Finset (Fin 2)) = {0, 1} := by decide
  have h2 : (({0} : Finset (Fin 2)).filter (fun j => j = (0 : Fin 2))).card = 1 := by decide
  simp [occ, annih, jwSign, EuclideanSpace.single_apply, h1, h2]

end BookProof.SmCar

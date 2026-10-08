import Definitions.Def_ChapterWignerLittleGroup
import Mathlib


/-!
# Wigner's classification: the orbits of `SL(2,ℂ)` on momentum space

`BookProof.ChapterWignerLittleGroup` computes the little groups of the reference momenta and
proves transitivity on the massive future shell and on the future light cone.  Its recorded
boundary was that only the *first* orbit invariant, the Minkowski square `p·p`, is treated
there: "the second invariant, the sign of the energy, is not formalized here".  This file
removes that boundary and completes Wigner's classification of the orbits.

## Results

* `hermOfMom_injective` — a momentum is determined by its Hermitian matrix, and
  `hermOfMom_eq_zero_iff`;
* `hermOfMom_posSemidef` — for a momentum in the closed future cone (`0 ≤ p⁰`,
  `0 ≤ p·p`) the matrix `hermOfMom p` is positive semidefinite.  The proof reduces along
  the boost supplied by the transitivity theorems to the diagonal reference matrices
  `diag(m, m)` and `diag(2, 0)`;
* **`energy_nonneg_of_act`** and **`energy_pos_of_act`** — the sign of the energy is an
  orbit invariant: an `SL(2,ℂ)` transform of a future-pointing momentum with `p·p ≥ 0` is
  future-pointing.  Hence `future_cone_invariant`: the closed future cone, the open future
  cone, the future mass shells and the future light cone are unions of orbits;
* **`orbit_iff_massSq_eq`** — two momenta in the open future cone with `p·p ≥ 0` are in the
  same orbit **iff** they have the same Minkowski square: together with the previous item,
  `p·p` and the sign of `p⁰` are a complete set of invariants for these momenta;
* `littleGroup_zero` — the little group of the zero momentum is all of `SL(2,ℂ)`;
* `littleGroup_spacelike` — the little group of the spacelike reference momentum
  `(0,0,0,1)` is `SU(1,1)`, the stabilizer of the form `diag(1,-1)`, so that the third kind
  of orbit (the tachyonic shells) carries the remaining little group of the classification.

Everything is `sorry`-free and uses only the standard axioms.
-/

open Matrix Complex
open scoped ComplexOrder

namespace BookProof.ChapterWignerLittleGroupOrbits

open BookProof.ChapterWignerLittleGroup

/-! ## The momentum is determined by its matrix -/







/-! ## Positive semidefiniteness in the closed future cone -/





/-! ## Inverting the action -/





/-! ## The sign of the energy is an orbit invariant -/







/-! ## The orbits of the future cone -/



/-! ## The remaining orbits: the origin and the spacelike shells -/



/-- The spacelike reference momentum `(0,0,0,1)`. -/
def spaceMom : Fin 4 → ℝ := ![0, 0, 0, 1]



/-- `SU(1,1)`: the stabilizer in `SL(2,ℂ)` of the indefinite form `diag(1,-1)`. -/
def SU11 : Set (Matrix (Fin 2) (Fin 2) ℂ) :=
  {A | A.det = 1 ∧ A * !![(1 : ℂ), 0; 0, -1] * Aᴴ = !![(1 : ℂ), 0; 0, -1]}ive future shell and on the future light cone.  Its recorded
boundary was that only the *first* orbit invariant, the Minkowski square `p·p`, is treated
there: "the second invariant, the sign of the energy, is not formalized here".  This file
removes that boundary and completes Wigner's classification of the orbits.

## Results

* `hermOfMom_injective` — a momentum is determined by its Hermitian matrix, and
  `hermOfMom_eq_zero_iff`;
* `hermOfMom_posSemidef` — for a momentum in the closed future cone (`0 ≤ p⁰`,
  `0 ≤ p·p`) the matrix `hermOfMom p` is positive semidefinite.  The proof reduces along
  the boost supplied by the transitivity theorems to the diagonal reference matrices
  `diag(m, m)` and `diag(2, 0)`;
* **`energy_nonneg_of_act`** and **`energy_pos_of_act`** — the sign of the energy is an
  orbit invariant: an `SL(2,ℂ)` transform of a future-pointing momentum with `p·p ≥ 0` is
  future-pointing.  Hence `future_cone_invariant`: the closed future cone, the open future
  cone, the future mass shells and the future light cone are unions of orbits;
* **`orbit_iff_massSq_eq`** — two momenta in the open future cone with `p·p ≥ 0` are in the
  same orbit **iff** they have the same Minkowski square: together with the previous item,
  `p·p` and the sign of `p⁰` are a complete set of invariants for these momenta;
* `littleGroup_zero` — the little group of the zero momentum is all of `SL(2,ℂ)`;
* `littleGroup_spacelike` — the little group of the spacelike reference momentum
  `(0,0,0,1)` is `SU(1,1)`, the stabilizer of the form `diag(1,-1)`, so that the third kind
  of orbit (the tachyonic shells) carries the remaining little group of the classification.

Everything is `sorry`-free and uses only the standard axioms.
-/

open Matrix Complex
open scoped ComplexOrder

namespace BookProof.ChapterWignerLittleGroupOrbits

open BookProof.ChapterWignerLittleGroup

/-! ## The momentum is determined by its matrix -/

theorem hermOfMom_injective {p q : Fin 4 → ℝ} (h : hermOfMom p = hermOfMom q) :
    ∀ i, p i = q i := by
  have h00 := congrFun (congrFun h 0) 0
  have h11 := congrFun (congrFun h 1) 1
  have h01 := congrFun (congrFun h 0) 1
  simp only [hermOfMom, Matrix.cons_val', Matrix.cons_val_zero, Matrix.cons_val_one,
    Matrix.empty_val', Matrix.cons_val_fin_one, Matrix.of_apply] at h00 h11 h01
  have e0 : p 0 + p 3 = q 0 + q 3 := by exact_mod_cast congrArg Complex.re h00
  have e1 : p 0 - p 3 = q 0 - q 3 := by exact_mod_cast congrArg Complex.re h11
  have e2 : p 1 = q 1 := by
    have := congrArg Complex.re h01
    simpa using this
  have e3 : p 2 = q 2 := by
    have := congrArg Complex.im h01
    simp at this
    linarith
  intro i
  fin_cases i
  · simpa using (by linarith : p 0 = q 0)
  · simpa using e2
  · simpa using e3
  · simpa using (by linarith : p 3 = q 3)

theorem hermOfMom_zero : hermOfMom (fun _ => 0) = 0 := by
  ext i j
  fin_cases i <;> fin_cases j <;> simp [hermOfMom]

theorem hermOfMom_eq_zero_iff {p : Fin 4 → ℝ} : hermOfMom p = 0 ↔ ∀ i, p i = 0 := by
  constructor
  · intro h
    have := hermOfMom_injective (q := fun _ => 0) (by rw [h, hermOfMom_zero])
    simpa using this
  · intro h
    have : hermOfMom p = hermOfMom (fun _ => 0) := by
      congr 1
      funext i
      simp [h i]
    rw [this, hermOfMom_zero]

/-! ## Positive semidefiniteness in the closed future cone -/

/-- A real diagonal `2×2` matrix with nonnegative entries is positive semidefinite. -/
theorem posSemidef_diag2 {c d : ℝ} (hc : 0 ≤ c) (hd : 0 ≤ d) :
    (!![(c : ℂ), 0; 0, (d : ℂ)]).PosSemidef := by
  have hdiag : !![(c : ℂ), 0; 0, (d : ℂ)] = Matrix.diagonal ![(c : ℂ), (d : ℂ)] := by
    ext i j
    fin_cases i <;> fin_cases j <;> simp [Matrix.diagonal]
  rw [hdiag, Matrix.posSemidef_diagonal_iff]
  intro i
  fin_cases i
  · simpa using Complex.zero_le_real.mpr hc
  · simpa using Complex.zero_le_real.mpr hd

/-- **The matrix of a momentum in the closed future cone is positive semidefinite.** -/
theorem hermOfMom_posSemidef {p : Fin 4 → ℝ} (hp0 : 0 ≤ p 0)
    (hmass : 0 ≤ p 0 ^ 2 - p 1 ^ 2 - p 2 ^ 2 - p 3 ^ 2) :
    (hermOfMom p).PosSemidef := by
  rcases eq_or_lt_of_le hp0 with hzero | hpos
  · -- `p⁰ = 0` forces `p = 0`
    have hp : ∀ i, p i = 0 := by
      have h1 : p 1 ^ 2 + p 2 ^ 2 + p 3 ^ 2 ≤ 0 := by nlinarith [hmass, hzero]
      have h1' : p 1 = 0 := by nlinarith [sq_nonneg (p 1), sq_nonneg (p 2), sq_nonneg (p 3)]
      have h2' : p 2 = 0 := by nlinarith [sq_nonneg (p 1), sq_nonneg (p 2), sq_nonneg (p 3)]
      have h3' : p 3 = 0 := by nlinarith [sq_nonneg (p 1), sq_nonneg (p 2), sq_nonneg (p 3)]
      intro i
      fin_cases i
      · simpa using hzero.symm
      · simpa using h1'
      · simpa using h2'
      · simpa using h3'
    rw [hermOfMom_eq_zero_iff.2 hp]
    exact Matrix.PosSemidef.zero
  · rcases eq_or_lt_of_le hmass with hnull | hmassive
    · -- lightlike: reduce to `diag(2, 0)`
      obtain ⟨A, _, hA⟩ := exists_boost_null p hpos (by linarith)
      rw [← hA, act, hermOfMom_nullMom]
      have h2 : (!![(2 : ℂ), 0; 0, 0]) = !![((2 : ℝ) : ℂ), 0; 0, ((0 : ℝ) : ℂ)] := by
        norm_num
      rw [h2]
      exact (posSemidef_diag2 (by norm_num) le_rfl).mul_mul_conjTranspose_same A
    · -- massive: reduce to `diag(m, m)`
      set m : ℝ := Real.sqrt (p 0 ^ 2 - p 1 ^ 2 - p 2 ^ 2 - p 3 ^ 2) with hm
      have hmpos : 0 < m := Real.sqrt_pos.2 hmassive
      have hm2 : m ^ 2 = p 0 ^ 2 - p 1 ^ 2 - p 2 ^ 2 - p 3 ^ 2 := Real.sq_sqrt (le_of_lt hmassive)
      obtain ⟨A, _, hA⟩ := exists_boost_massive hmpos p hpos hm2.symm
      have hdiag : ((m : ℂ) • (1 : Matrix (Fin 2) (Fin 2) ℂ)) = !![(m : ℂ), 0; 0, (m : ℂ)] := by
        ext i j
        fin_cases i <;> fin_cases j <;> simp
      rw [← hA, act, hermOfMom_restMom, hdiag]
      exact (posSemidef_diag2 (le_of_lt hmpos) (le_of_lt hmpos)).mul_mul_conjTranspose_same A

/-! ## Inverting the action -/

theorem act_inv_of_act {A X Y : Matrix (Fin 2) (Fin 2) ℂ} (hA : A.det = 1) (h : act A X = Y) :
    act A⁻¹ Y = X := by
  have hunit : IsUnit A.det := by rw [hA]; exact isUnit_one
  rw [← h, ← act_mul, Matrix.nonsing_inv_mul A hunit, act_one]

theorem det_inv_eq_one {A : Matrix (Fin 2) (Fin 2) ℂ} (hA : A.det = 1) : (A⁻¹).det = 1 := by
  rw [Matrix.det_nonsing_inv, hA]
  simp

/-! ## The sign of the energy is an orbit invariant -/

/-- **The energy of a transformed future momentum is nonnegative.** -/
theorem energy_nonneg_of_act {A : Matrix (Fin 2) (Fin 2) ℂ} {p q : Fin 4 → ℝ}
    (hp0 : 0 ≤ p 0) (hmass : 0 ≤ p 0 ^ 2 - p 1 ^ 2 - p 2 ^ 2 - p 3 ^ 2)
    (h : act A (hermOfMom p) = hermOfMom q) : 0 ≤ q 0 := by
  have hpsd : (hermOfMom q).PosSemidef := by
    rw [← h, act]
    exact (hermOfMom_posSemidef hp0 hmass).mul_mul_conjTranspose_same A
  have htr : (0 : ℂ) ≤ ((2 * q 0 : ℝ) : ℂ) := by
    have := hpsd.trace_nonneg
    rwa [hermOfMom_trace] at this
  have : (0 : ℝ) ≤ 2 * q 0 := Complex.zero_le_real.mp htr
  linarith

/-- **The sign of the energy is an orbit invariant.**  An `SL(2,ℂ)` transform of a momentum
in the open future cone (with `p·p ≥ 0`) again has strictly positive energy. -/
theorem energy_pos_of_act {A : Matrix (Fin 2) (Fin 2) ℂ} (hA : A.det = 1) {p q : Fin 4 → ℝ}
    (hp0 : 0 < p 0) (hmass : 0 ≤ p 0 ^ 2 - p 1 ^ 2 - p 2 ^ 2 - p 3 ^ 2)
    (h : act A (hermOfMom p) = hermOfMom q) : 0 < q 0 := by
  have hnn : 0 ≤ q 0 := energy_nonneg_of_act (le_of_lt hp0) hmass h
  rcases eq_or_lt_of_le hnn with hzero | hpos
  · -- `q⁰ = 0` and `q·q ≥ 0` force `q = 0`, hence `p = 0`, contradicting `p⁰ > 0`
    exfalso
    have hq : q 0 ^ 2 - q 1 ^ 2 - q 2 ^ 2 - q 3 ^ 2 = p 0 ^ 2 - p 1 ^ 2 - p 2 ^ 2 - p 3 ^ 2 :=
      mass_invariant hA h
    have hq0 : q 0 = 0 := hzero.symm
    have hzeroes : ∀ i, q i = 0 := by
      have hle : q 1 ^ 2 + q 2 ^ 2 + q 3 ^ 2 ≤ 0 := by nlinarith [hq, hmass, hq0]
      have h1' : q 1 = 0 := by nlinarith [sq_nonneg (q 1), sq_nonneg (q 2), sq_nonneg (q 3)]
      have h2' : q 2 = 0 := by nlinarith [sq_nonneg (q 1), sq_nonneg (q 2), sq_nonneg (q 3)]
      have h3' : q 3 = 0 := by nlinarith [sq_nonneg (q 1), sq_nonneg (q 2), sq_nonneg (q 3)]
      intro i
      fin_cases i
      · simpa using hq0
      · simpa using h1'
      · simpa using h2'
      · simpa using h3'
    have hqzero : hermOfMom q = 0 := hermOfMom_eq_zero_iff.2 hzeroes
    -- invert the action
    have hp : hermOfMom p = 0 := by
      have hback := act_inv_of_act hA h
      rw [hqzero, act, Matrix.mul_zero, Matrix.zero_mul] at hback
      exact hback.symm
    have := (hermOfMom_eq_zero_iff.1 hp) 0
    linarith
  · exact hpos

/-- **The future cone is a union of orbits.**  Both the closed and the open future cone
(intersected with `p·p ≥ 0`) are invariant under the action, and the Minkowski square is
preserved. -/
theorem future_cone_invariant {A : Matrix (Fin 2) (Fin 2) ℂ} (hA : A.det = 1) {p q : Fin 4 → ℝ}
    (hp0 : 0 < p 0) (hmass : 0 ≤ p 0 ^ 2 - p 1 ^ 2 - p 2 ^ 2 - p 3 ^ 2)
    (h : act A (hermOfMom p) = hermOfMom q) :
    0 < q 0 ∧ q 0 ^ 2 - q 1 ^ 2 - q 2 ^ 2 - q 3 ^ 2 = p 0 ^ 2 - p 1 ^ 2 - p 2 ^ 2 - p 3 ^ 2 :=
  ⟨energy_pos_of_act hA hp0 hmass h, mass_invariant hA h⟩

/-! ## The orbits of the future cone -/

/-- **Wigner's orbit classification in the future cone.**  Two momenta with positive energy
and nonnegative Minkowski square lie in the same `SL(2,ℂ)` orbit precisely when their
Minkowski squares agree.  Together with `energy_pos_of_act` this says that the pair
(Minkowski square, sign of the energy) is a complete invariant: the orbits are the future
mass shells, the future light cone and — by `hermOfMom_zero` — the origin. -/
theorem orbit_iff_massSq_eq {p q : Fin 4 → ℝ} (hp0 : 0 < p 0) (hq0 : 0 < q 0)
    (hmass : 0 ≤ p 0 ^ 2 - p 1 ^ 2 - p 2 ^ 2 - p 3 ^ 2) :
    (∃ A : Matrix (Fin 2) (Fin 2) ℂ, A.det = 1 ∧ act A (hermOfMom p) = hermOfMom q) ↔
      q 0 ^ 2 - q 1 ^ 2 - q 2 ^ 2 - q 3 ^ 2 = p 0 ^ 2 - p 1 ^ 2 - p 2 ^ 2 - p 3 ^ 2 := by
  constructor
  · rintro ⟨A, hA, h⟩
    exact mass_invariant hA h
  · intro hsq
    -- both are boosts of the same reference momentum
    rcases eq_or_lt_of_le hmass with hnull | hmassive
    · obtain ⟨A₁, hA₁, h₁⟩ := exists_boost_null p hp0 (by linarith)
      obtain ⟨A₂, hA₂, h₂⟩ := exists_boost_null q hq0 (by linarith [hsq])
      refine ⟨A₂ * A₁⁻¹, by rw [Matrix.det_mul, hA₂, det_inv_eq_one hA₁]; ring, ?_⟩
      rw [act_mul, act_inv_of_act hA₁ h₁, h₂]
    · set m : ℝ := Real.sqrt (p 0 ^ 2 - p 1 ^ 2 - p 2 ^ 2 - p 3 ^ 2) with hm
      have hmpos : 0 < m := Real.sqrt_pos.2 hmassive
      have hm2 : m ^ 2 = p 0 ^ 2 - p 1 ^ 2 - p 2 ^ 2 - p 3 ^ 2 := Real.sq_sqrt (le_of_lt hmassive)
      obtain ⟨A₁, hA₁, h₁⟩ := exists_boost_massive hmpos p hp0 hm2.symm
      obtain ⟨A₂, hA₂, h₂⟩ := exists_boost_massive hmpos q hq0 (by rw [hsq]; exact hm2.symm)
      refine ⟨A₂ * A₁⁻¹, by rw [Matrix.det_mul, hA₂, det_inv_eq_one hA₁]; ring, ?_⟩
      rw [act_mul, act_inv_of_act hA₁ h₁, h₂]

/-! ## The remaining orbits: the origin and the spacelike shells -/

/-- The little group of the zero momentum is the whole of `SL(2,ℂ)`. -/
theorem littleGroup_zero :
    littleGroup (fun _ => 0) = {A : Matrix (Fin 2) (Fin 2) ℂ | A.det = 1} := by
  ext A
  simp only [littleGroup, Set.mem_setOf_eq, hermOfMom_zero, act, Matrix.mul_zero,
    Matrix.zero_mul, and_true]

/-- The spacelike reference momentum `(0,0,0,1)`. -/
def spaceMom : Fin 4 → ℝ := ![0, 0, 0, 1]

theorem hermOfMom_spaceMom : hermOfMom spaceMom = !![(1 : ℂ), 0; 0, -1] := by
  ext i j
  fin_cases i <;> fin_cases j <;> simp [hermOfMom, spaceMom]

/-- `SU(1,1)`: the stabilizer in `SL(2,ℂ)` of the indefinite form `diag(1,-1)`. -/
def SU11 : Set (Matrix (Fin 2) (Fin 2) ℂ) :=
  {A | A.det = 1 ∧ A * !![(1 : ℂ), 0; 0, -1] * Aᴴ = !![(1 : ℂ), 0; 0, -1]}

/-- **The spacelike little group is `SU(1,1)`.**  With `littleGroup_conj` of
`BookProof.ChapterWignerLittleGroup` this gives the little group of every momentum in the
orbit of `(0,0,0,1)`. -/
theorem littleGroup_spacelike : littleGroup spaceMom = SU11 := by
  ext A
  simp [littleGroup, SU11, act, hermOfMom_spaceMom]

end BookProof.ChapterWignerLittleGroupOrbits

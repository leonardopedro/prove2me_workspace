import Mathlib
import BookProof.ChapterA3
import BookProof.ChapterA3b
import BookProof.ChapterA3c

/-!
# Chapter A, §A.3 — the discrete Pin subgroup `Ω` (Definition 49)

This file continues work-package **N4** of `FORMALIZATION_ROADMAP.md`
(book §A.3, line 5476), formalizing **Definition 49**: the *discrete Pin
subgroup*

`Ω := {±1, ±iγ⁰, ±γ⁰γ⁵, ±iγ⁵} ⊆ Pin(3,1)`,

which is the **double cover of the discrete Lorentz subgroup**
`Δ := {1, η, -η, -1} ⊆ O(1,3)`.

Everything is stated over `ℝ` on the concrete `4×4` Majorana matrix model of
`ChapterA3.lean` / `ChapterA3c.lean`, and is fully self-contained: no external
hypothesis (no Pauli/Weyl input) is needed, since `Ω` is a finite explicit set
and each membership/`Λ`-value is a concrete matrix computation.

Deliverables:
* `OmegaPin`, `LorentzDelta` — the finite sets `Ω`, `Δ`.
* `omega_subset_pin` — every element of `Ω` is in `Pin(3,1)`.
* `lambda_omega_mem_delta` — `Λ(ω) ∈ Δ` for every `ω ∈ Ω` (the 2-to-1 cover
  `Ω → Δ`), with the explicit values `Λ(±iγ⁰) = η`, `Λ(±γ⁰γ⁵) = -η`,
  `Λ(±iγ⁵) = -1`, `Λ(±1) = 1`.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open Matrix

namespace BookProof.ChapterA3

/-! ## The integer generators of `Ω` -/

/-- `iγ⁰` as an integer matrix (a generator of `Ω`). -/
def omegaA0Z : Matrix (Fin 4) (Fin 4) ℤ := mgammaZ 0

/-- `iγ⁵` as an integer matrix (a generator of `Ω`). -/
def omegaA5Z : Matrix (Fin 4) (Fin 4) ℤ := mgamma5Z

/-- `γ⁰γ⁵ = -(iγ⁰)(iγ⁵)` as an integer matrix (a generator of `Ω`). -/
def omegaG05Z : Matrix (Fin 4) (Fin 4) ℤ := -(mgammaZ 0 * mgamma5Z)

/-- The integer Minkowski metric as a matrix `η = diag(1,-1,-1,-1)`. -/
def minkowskiMatZ : Matrix (Fin 4) (Fin 4) ℤ := Matrix.of minkowskiZ

/-- Casting `-1` through the integer-matrix ring hom. -/
theorem castMat_neg_one :
    (Int.castRingHom ℝ).mapMatrix (-1 : Matrix (Fin 4) (Fin 4) ℤ) = -1 := by
  rw [map_neg, map_one]

/-! ## The real generators of `Ω` -/

/-- `iγ⁰` as a real matrix. -/
noncomputable def omegaA0 : Matrix (Fin 4) (Fin 4) ℝ := mgammaR 0

/-- `iγ⁵` as a real matrix. -/
noncomputable def omegaA5 : Matrix (Fin 4) (Fin 4) ℝ :=
  (Int.castRingHom ℝ).mapMatrix omegaA5Z

/-- `γ⁰γ⁵` as a real matrix. -/
noncomputable def omegaG05 : Matrix (Fin 4) (Fin 4) ℝ :=
  (Int.castRingHom ℝ).mapMatrix omegaG05Z

/-- The **discrete Lorentz subgroup** `Δ = {1, η, -η, -1}`. -/
def LorentzDelta : Set (Matrix (Fin 4) (Fin 4) ℝ) :=
  {1, minkowskiMat, -minkowskiMat, -1}

/-- The **discrete Pin subgroup** `Ω = {±1, ±iγ⁰, ±γ⁰γ⁵, ±iγ⁵}`. -/
def OmegaPin : Set (Matrix (Fin 4) (Fin 4) ℝ) :=
  {1, -1, omegaA0, -omegaA0, omegaG05, -omegaG05, omegaA5, -omegaA5}

/-! ## Generic helpers -/

/-- If `S² = -1` then `S⁻¹ = -S`. -/
theorem inv_of_sq_neg_one {S : Matrix (Fin 4) (Fin 4) ℝ} (h : S * S = -1) :
    S⁻¹ = -S := by
  apply Matrix.inv_eq_left_inv
  rw [Matrix.neg_mul, h, neg_neg]

/-- If `S² = -1` then `det S · det S = 1`. -/
theorem det_sq_of_sq_neg_one {S : Matrix (Fin 4) (Fin 4) ℝ} (h : S * S = -1) :
    S.det * S.det = 1 := by
  have hd := congrArg Matrix.det h
  rw [Matrix.det_mul] at hd
  rw [hd]
  norm_num [Matrix.det_neg, Fintype.card_fin]

/-- **`Ω`-membership from `S² = -1`.**  If `S² = -1` and `S` has a conjugation
matrix `Λ` on the Majorana basis, then `S ∈ Pin(3,1)`. -/
theorem isPin_of_sq_neg_one {S : Matrix (Fin 4) (Fin 4) ℝ} (h : S * S = -1)
    (hL : ∃ Λ, HasLambda S Λ) : IsPin S := by
  have hdet : S.det * S.det = 1 := det_sq_of_sq_neg_one h
  refine ⟨isUnit_iff_ne_zero.mpr (by rintro hz; rw [hz] at hdet; simp at hdet), ?_, hL⟩
  have h2 : |S.det| * |S.det| = 1 := by rw [← abs_mul, hdet, abs_one]
  nlinarith [abs_nonneg S.det, h2]

/-- **Reduction to the integer model.**  If `Sz² = -1` (so `S⁻¹ = -S`) and the
integer conjugation `-Sz · iγ^μ · Sz = Σ_ν Λz^μ_ν iγ^ν` holds, then the real
casts satisfy `HasLambda`. -/
theorem hasLambda_of_intModel (Sz Λz : Matrix (Fin 4) (Fin 4) ℤ)
    (hSS : Sz * Sz = -1)
    (hconj : ∀ μ, -Sz * mgammaZ μ * Sz = ∑ ν, Λz μ ν • mgammaZ ν) :
    HasLambda ((Int.castRingHom ℝ).mapMatrix Sz)
      ((Int.castRingHom ℝ).mapMatrix Λz) := by
  intro μ
  have hSSr : (Int.castRingHom ℝ).mapMatrix Sz * (Int.castRingHom ℝ).mapMatrix Sz = -1 := by
    rw [← map_mul, hSS, castMat_neg_one]
  have hinv : ((Int.castRingHom ℝ).mapMatrix Sz)⁻¹ = -((Int.castRingHom ℝ).mapMatrix Sz) :=
    inv_of_sq_neg_one hSSr
  rw [hinv]
  have hmg : mgammaR μ = (Int.castRingHom ℝ).mapMatrix (mgammaZ μ) := rfl
  have hL : -((Int.castRingHom ℝ).mapMatrix Sz) * mgammaR μ * (Int.castRingHom ℝ).mapMatrix Sz
      = (Int.castRingHom ℝ).mapMatrix (-Sz * mgammaZ μ * Sz) := by
    rw [hmg]; simp only [map_mul, map_neg]
  rw [hL, hconj μ, map_sum]
  apply Finset.sum_congr rfl
  intro ν _
  have hcast : ((Int.castRingHom ℝ).mapMatrix Λz) μ ν = ((Λz μ ν : ℤ) : ℝ) := by
    simp [RingHom.mapMatrix_apply, Matrix.map_apply]
  rw [hcast, map_zsmul, Int.cast_smul_eq_zsmul]
  rfl

/-! ## The generator `iγ⁰` -/

theorem omegaA0_sq : omegaA0 * omegaA0 = -1 := by
  have h : (mgammaZ 0 * mgammaZ 0) = -1 := by decide
  unfold omegaA0 mgammaR
  rw [← map_mul, h, castMat_neg_one]

theorem hasLambda_omegaA0 : HasLambda omegaA0 minkowskiMat := by
  have h := hasLambda_of_intModel omegaA0Z minkowskiMatZ (by decide)
    (by intro μ; fin_cases μ <;>
      simp [minkowskiMatZ, minkowskiZ, mgammaZ, omegaA0Z])
  have e1 : (Int.castRingHom ℝ).mapMatrix omegaA0Z = omegaA0 := rfl
  have e2 : (Int.castRingHom ℝ).mapMatrix minkowskiMatZ = minkowskiMat := by
    ext i j
    simp [RingHom.mapMatrix_apply, Matrix.map_apply, minkowskiMatZ, minkowskiMat, minkowskiR]
  rw [e1, e2] at h; exact h

theorem isPin_omegaA0 : IsPin omegaA0 :=
  isPin_of_sq_neg_one omegaA0_sq ⟨_, hasLambda_omegaA0⟩

theorem lambdaOf_omegaA0 : LambdaOf omegaA0 = minkowskiMat :=
  hasLambda_unique (hasLambda_LambdaOf _ isPin_omegaA0.2.2) hasLambda_omegaA0

/-! ## The generator `iγ⁵` -/

theorem omegaA5_sq : omegaA5 * omegaA5 = -1 := by
  have h : (mgamma5Z * mgamma5Z) = -1 := by decide
  unfold omegaA5 omegaA5Z
  rw [← map_mul, h, castMat_neg_one]

theorem hasLambda_omegaA5 : HasLambda omegaA5 (-1) := by
  have h := hasLambda_of_intModel omegaA5Z (-1) (by decide) (by decide)
  have e1 : (Int.castRingHom ℝ).mapMatrix omegaA5Z = omegaA5 := rfl
  rw [e1, castMat_neg_one] at h; exact h

theorem isPin_omegaA5 : IsPin omegaA5 :=
  isPin_of_sq_neg_one omegaA5_sq ⟨_, hasLambda_omegaA5⟩

theorem lambdaOf_omegaA5 : LambdaOf omegaA5 = -1 :=
  hasLambda_unique (hasLambda_LambdaOf _ isPin_omegaA5.2.2) hasLambda_omegaA5

/-! ## The generator `γ⁰γ⁵` -/

theorem omegaG05_sq : omegaG05 * omegaG05 = -1 := by
  have h : (omegaG05Z * omegaG05Z) = -1 := by decide
  unfold omegaG05
  rw [← map_mul, h, castMat_neg_one]

theorem hasLambda_omegaG05 : HasLambda omegaG05 (-minkowskiMat) := by
  have h := hasLambda_of_intModel omegaG05Z (-minkowskiMatZ) (by decide)
    (by intro μ; fin_cases μ <;>
      simp [minkowskiMatZ, minkowskiZ, mgammaZ, mgamma5Z, omegaG05Z])
  have e1 : (Int.castRingHom ℝ).mapMatrix omegaG05Z = omegaG05 := rfl
  have e2 : (Int.castRingHom ℝ).mapMatrix (-minkowskiMatZ) = -minkowskiMat := by
    ext i j
    simp [RingHom.mapMatrix_apply, Matrix.map_apply, minkowskiMatZ, minkowskiMat, minkowskiR]
  rw [e1, e2] at h; exact h

theorem isPin_omegaG05 : IsPin omegaG05 :=
  isPin_of_sq_neg_one omegaG05_sq ⟨_, hasLambda_omegaG05⟩

theorem lambdaOf_omegaG05 : LambdaOf omegaG05 = -minkowskiMat :=
  hasLambda_unique (hasLambda_LambdaOf _ isPin_omegaG05.2.2) hasLambda_omegaG05

/-! ## The identity generators `±1` -/

theorem hasLambda_one : HasLambda (1 : Matrix (Fin 4) (Fin 4) ℝ) 1 := by
  intro μ
  simp [Matrix.one_apply]

theorem isPin_one : IsPin (1 : Matrix (Fin 4) (Fin 4) ℝ) := by
  refine ⟨by simp, by simp, ⟨1, hasLambda_one⟩⟩

theorem lambdaOf_one : LambdaOf (1 : Matrix (Fin 4) (Fin 4) ℝ) = 1 :=
  hasLambda_unique (hasLambda_LambdaOf _ isPin_one.2.2) hasLambda_one

/-! ## `Ω` covers `Δ` two-to-one -/

/-- **Definition 49 (Pin membership).**  Every element of `Ω` lies in
`Pin(3,1)`. -/
theorem omega_subset_pin : ∀ S ∈ OmegaPin, IsPin S := by
  intro S hS
  simp only [OmegaPin, Set.mem_insert_iff, Set.mem_singleton_iff] at hS
  rcases hS with h | h | h | h | h | h | h | h <;> subst h
  · exact isPin_one
  · simpa using isPin_neg isPin_one
  · exact isPin_omegaA0
  · exact isPin_neg isPin_omegaA0
  · exact isPin_omegaG05
  · exact isPin_neg isPin_omegaG05
  · exact isPin_omegaA5
  · exact isPin_neg isPin_omegaA5

/-- **Definition 49 (double cover).**  `Λ(ω) ∈ Δ` for every `ω ∈ Ω`; i.e. the
group homomorphism `Λ` restricts to a map `Ω → Δ`. -/
theorem lambda_omega_mem_delta : ∀ S ∈ OmegaPin, LambdaOf S ∈ LorentzDelta := by
  intro S hS
  simp only [OmegaPin, Set.mem_insert_iff, Set.mem_singleton_iff] at hS
  have hneg1 : LambdaOf (-1 : Matrix (Fin 4) (Fin 4) ℝ) = 1 := by
    have hh := lambdaOf_neg isPin_one
    rw [lambdaOf_one] at hh
    simpa using hh
  rcases hS with h | h | h | h | h | h | h | h <;> subst h
  · rw [lambdaOf_one]; left; rfl
  · rw [hneg1]; left; rfl
  · rw [lambdaOf_omegaA0]; right; left; rfl
  · rw [lambdaOf_neg isPin_omegaA0, lambdaOf_omegaA0]; right; left; rfl
  · rw [lambdaOf_omegaG05]; right; right; left; rfl
  · rw [lambdaOf_neg isPin_omegaG05, lambdaOf_omegaG05]; right; right; left; rfl
  · rw [lambdaOf_omegaA5]; right; right; right; rfl
  · rw [lambdaOf_neg isPin_omegaA5, lambdaOf_omegaA5]; right; right; right; rfl

/-- **`Δ` is a subgroup of `O(1,3)`.**  Each element of the discrete Lorentz
subgroup `Δ = {1, η, -η, -1}` is a genuine Lorentz transformation.  (This
confirms that `Λ : Ω → Δ` really does land in `O(1,3)`.) -/
theorem delta_subset_lorentz : LorentzDelta ⊆ LorentzO := by
  intro Λ hΛ
  simp only [LorentzDelta, Set.mem_insert_iff, Set.mem_singleton_iff] at hΛ
  rcases hΛ with h | h | h | h <;> subst h
  · simp [LorentzO]
  · have := lambda_mem_lorentz omegaA0 isPin_omegaA0; rwa [lambdaOf_omegaA0] at this
  · have := lambda_mem_lorentz omegaG05 isPin_omegaG05; rwa [lambdaOf_omegaG05] at this
  · have := lambda_mem_lorentz omegaA5 isPin_omegaA5; rwa [lambdaOf_omegaA5] at this

end BookProof.ChapterA3

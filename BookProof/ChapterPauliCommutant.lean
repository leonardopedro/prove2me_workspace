import Mathlib
import BookProof.ChapterA3

/-!
# Chapter A, §A.3 — the commutant of the concrete Majorana/Dirac γ-matrices

`BookProof/ChapterA3b.lean` takes the **Pauli fundamental theorem** (Note 36) as
an `EXTERNAL` named hypothesis `PauliFundamental`, because in the stated
generality (all complex Clifford sets on `ℂ⁴`) it is not available in Mathlib.

This file discharges the `EXTERNAL` flag **for the fixed 4×4 model** built in
`BookProof/ChapterA3.lean`: it proves, by an explicit finite computation, the
Schur-type statement

  *any complex `4×4` matrix commuting with all four Majorana matrices `iγ^μ`
  is a scalar multiple of the identity,*

together with its immediate consequences:

* `mgamma_commutant_scalar` / `mgamma_commutant_iff` — the commutant of
  `{iγ⁰, iγ¹, iγ², iγ³}` in `Mat(4, ℂ)` is exactly `ℂ · 1`;
* `mgamma5_of_commutes` — such a matrix automatically commutes with `iγ⁵` too;
* `dgamma_commutant_scalar` — the same for the Dirac matrices `γ^μ = -i(iγ^μ)`;
* `mgamma_conjugation_unique_up_to_scalar` — the **uniqueness clause** of the
  Pauli fundamental theorem for the concrete family: two invertible matrices
  conjugating the `iγ^μ` to the same set differ by a nonzero scalar;
* `mgamma_conj_eq_self_iff` — the stabiliser of the family under conjugation is
  the group of scalars.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`); **no `EXTERNAL` hypothesis is used**.
-/

open Matrix

namespace BookProof.ChapterA3

/-- **Schur's lemma for the concrete Majorana representation.**
Any complex `4×4` matrix `M` that commutes with each of the four Majorana
matrices `iγ^μ` is the scalar matrix `M₀₀ · 1`.

This is the concrete instance of the Pauli fundamental theorem's irreducibility
input (Note 36); it is proved here by solving the linear system explicitly, so
it needs no external hypothesis. -/
theorem mgamma_commutant_scalar (M : Matrix (Fin 4) (Fin 4) ℂ)
    (h : ∀ μ, M * mgamma μ = mgamma μ * M) :
    M = M 0 0 • (1 : Matrix (Fin 4) (Fin 4) ℂ) := by
  have h0 := h 0; have h1 := h 1; have h2 := h 2; have h3 := h 3
  rw [← Matrix.ext_iff] at h0 h1 h2 h3
  simp only [mgamma, mgammaZ, Int.reduceNeg, RingHom.mapMatrix_apply, Int.coe_castRingHom,
    mul_apply, map_apply, of_apply, cons_val', cons_val_fin_one, Fin.sum_univ_four,
    Fin.isValue, cons_val_zero, cons_val_one, cons_val, Fin.forall_fin_succ, Int.cast_zero,
    mul_zero, add_zero, Int.cast_neg, Int.cast_one, mul_neg, mul_one, zero_add, cons_val_succ,
    Fin.succ_zero_eq_one, Fin.succ_one_eq_two, Fin.reduceSucc, IsEmpty.forall_iff, and_true,
    zero_mul, one_mul, neg_mul, neg_inj, true_and] at h0 h1 h2 h3
  obtain ⟨⟨-, p2, p3, -⟩, ⟨p5, -, -, p8⟩, -, -⟩ := h0
  obtain ⟨⟨q1, q2⟩, ⟨q3, q4⟩, ⟨q5, q6⟩, q7, q8⟩ := h1
  obtain ⟨⟨-, r2, -, -⟩, ⟨r5, -, -, -⟩, -, -⟩ := h2
  obtain ⟨⟨-, s2, -, -⟩, -, -, -⟩ := h3
  have e01 : M 0 1 = 0 := by linear_combination (-1 / 2 : ℂ) * q1
  have e02 : M 0 2 = 0 := by linear_combination (-1 / 2 : ℂ) * q2
  have e10 : M 1 0 = 0 := by linear_combination (1 / 2 : ℂ) * q3
  have e13 : M 1 3 = 0 := by linear_combination (1 / 2 : ℂ) * q4
  have e20 : M 2 0 = 0 := by linear_combination (1 / 2 : ℂ) * q5
  have e23 : M 2 3 = 0 := by linear_combination (1 / 2 : ℂ) * q6
  have e31 : M 3 1 = 0 := by linear_combination (-1 / 2 : ℂ) * q7
  have e32 : M 3 2 = 0 := by linear_combination (-1 / 2 : ℂ) * q8
  have e03 : M 0 3 = 0 := by linear_combination (-1 / 2 : ℂ) * p2 + (1 / 2 : ℂ) * r2
  have e21 : M 2 1 = 0 := by linear_combination -r2 + e03
  have e12 : M 1 2 = 0 := by linear_combination (-1 / 2 : ℂ) * p5 + (1 / 2 : ℂ) * r5
  have e30 : M 3 0 = 0 := by linear_combination -r5 + e12
  have e11 : M 1 1 = M 0 0 := by linear_combination -s2
  have e22 : M 2 2 = M 0 0 := by linear_combination -p3
  have e33 : M 3 3 = M 0 0 := by linear_combination -p8 - s2
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [e01, e02, e03, e10, e11, e12, e13, e20, e21, e22, e23, e30, e31, e32, e33]

/-- **The commutant of the Majorana family is exactly the scalars.** -/
theorem mgamma_commutant_iff (M : Matrix (Fin 4) (Fin 4) ℂ) :
    (∀ μ, M * mgamma μ = mgamma μ * M) ↔ ∃ c : ℂ, M = c • (1 : Matrix (Fin 4) (Fin 4) ℂ) := by
  constructor
  · intro h; exact ⟨M 0 0, mgamma_commutant_scalar M h⟩
  · rintro ⟨c, rfl⟩ μ
    simp []

/-- A matrix commuting with all four Majorana matrices automatically commutes
with the fifth one, `iγ⁵` (being a scalar). -/
theorem mgamma5_of_commutes (M : Matrix (Fin 4) (Fin 4) ℂ)
    (h : ∀ μ, M * mgamma μ = mgamma μ * M) :
    M * mgamma5 = mgamma5 * M := by
  rw [mgamma_commutant_scalar M h]
  simp []

/-- **Schur's lemma for the Dirac matrices.** Any complex `4×4` matrix commuting
with all four Dirac matrices `γ^μ = -i (iγ^μ)` is a scalar. -/
theorem dgamma_commutant_scalar (M : Matrix (Fin 4) (Fin 4) ℂ)
    (h : ∀ μ, M * dgamma μ = dgamma μ * M) :
    M = M 0 0 • (1 : Matrix (Fin 4) (Fin 4) ℂ) := by
  refine mgamma_commutant_scalar M fun μ => ?_
  have hI : (-Complex.I : ℂ) ≠ 0 := by simp [Complex.I_ne_zero]
  have := h μ
  rw [dgamma, Matrix.mul_smul, Matrix.smul_mul] at this
  exact smul_right_injective _ hI this

/-- **Uniqueness clause of the Pauli fundamental theorem, for the concrete model.**
If two invertible matrices `S`, `T` conjugate the Majorana family `iγ^μ` to the
same family, then they differ by a nonzero scalar. -/
theorem mgamma_conjugation_unique_up_to_scalar
    {S T : Matrix (Fin 4) (Fin 4) ℂ} (hS : IsUnit S.det) (hT : IsUnit T.det)
    (h : ∀ μ, S * mgamma μ * S⁻¹ = T * mgamma μ * T⁻¹) :
    ∃ c : ℂ, c ≠ 0 ∧ S = c • T := by
  have hTinv : T⁻¹ * T = 1 := Matrix.nonsing_inv_mul T hT
  have hTinv' : T * T⁻¹ = 1 := Matrix.mul_nonsing_inv T hT
  have hSinv : S⁻¹ * S = 1 := Matrix.nonsing_inv_mul S hS
  have hcomm : ∀ μ, (T⁻¹ * S) * mgamma μ = mgamma μ * (T⁻¹ * S) := by
    intro μ
    have h1 : S * mgamma μ = T * mgamma μ * T⁻¹ * S := by
      have h2 := congrArg (fun X => X * S) (h μ)
      simp only [Matrix.mul_assoc] at h2 ⊢
      rw [hSinv, Matrix.mul_one] at h2
      simpa [Matrix.mul_assoc] using h2
    calc (T⁻¹ * S) * mgamma μ = T⁻¹ * (S * mgamma μ) := by rw [Matrix.mul_assoc]
      _ = T⁻¹ * (T * mgamma μ * T⁻¹ * S) := by rw [h1]
      _ = mgamma μ * (T⁻¹ * S) := by
          simp only [Matrix.mul_assoc, ← Matrix.mul_assoc T⁻¹ T, hTinv, Matrix.one_mul]
  set c : ℂ := (T⁻¹ * S) 0 0 with hc
  have hU : T⁻¹ * S = c • (1 : Matrix (Fin 4) (Fin 4) ℂ) :=
    mgamma_commutant_scalar _ hcomm
  have hST : S = c • T := by
    have h3 : T * (T⁻¹ * S) = S := by rw [← Matrix.mul_assoc, hTinv', Matrix.one_mul]
    rw [hU] at h3
    rw [← h3]
    simp
  refine ⟨c, ?_, hST⟩
  intro hc0
  rw [hc0, zero_smul] at hST
  rw [hST] at hS
  rw [Matrix.det_zero ⟨0⟩] at hS
  exact hS.ne_zero rfl

/-- The stabiliser of the Majorana family under conjugation consists precisely of
the nonzero scalars: `S iγ^μ S⁻¹ = iγ^μ` for all `μ` iff `S = c · 1`, `c ≠ 0`. -/
theorem mgamma_conj_eq_self_iff {S : Matrix (Fin 4) (Fin 4) ℂ} (hS : IsUnit S.det) :
    (∀ μ, S * mgamma μ * S⁻¹ = mgamma μ) ↔
      ∃ c : ℂ, c ≠ 0 ∧ S = c • (1 : Matrix (Fin 4) (Fin 4) ℂ) := by
  constructor
  · intro h
    have hone : IsUnit (1 : Matrix (Fin 4) (Fin 4) ℂ).det := by simp
    refine (mgamma_conjugation_unique_up_to_scalar hS hone ?_).imp ?_
    · intro μ; simpa using h μ
    · intro c hc; exact ⟨hc.1, by simpa using hc.2⟩
  · rintro ⟨c, hc, rfl⟩ μ
    have hcinv : (c • (1 : Matrix (Fin 4) (Fin 4) ℂ))⁻¹ = c⁻¹ • 1 :=
      Matrix.inv_eq_right_inv (by
        rw [Matrix.smul_mul, Matrix.mul_smul, Matrix.one_mul, smul_smul,
          mul_inv_cancel₀ hc, one_smul])
    rw [hcinv]
    simp [smul_smul, mul_comm, mul_inv_cancel₀ hc]

/-! ## Irreducibility of the concrete Majorana representation

The commutant computation above is exactly the input Schur's lemma needs.  Here
it is turned around: because the Majorana family is closed under the adjoint (up
to a sign), the orthogonal projection onto an invariant subspace commutes with
every `iγ^μ`, hence is a scalar, hence the subspace is `⊥` or `⊤`.
-/

/-- The Euclidean space `ℂ⁴` carrying the Majorana representation. -/
noncomputable abbrev MajoranaSpace := EuclideanSpace ℂ (Fin 4)

/-- The Majorana matrices acting as linear maps on `ℂ⁴`. -/
noncomputable def mgammaLin (μ : Fin 4) : MajoranaSpace →ₗ[ℂ] MajoranaSpace :=
  Matrix.toEuclideanLin (mgamma μ)

/-- `iγ⁰` is antisymmetric and `iγ¹, iγ², iγ³` are symmetric, over `ℤ`. -/
theorem mgammaZ_transpose (μ : Fin 4) :
    (mgammaZ μ)ᵀ = (if μ = 0 then (-1 : ℤ) else 1) • mgammaZ μ := by revert μ; decide

/-- Consequently the Majorana family is closed under the conjugate transpose, up
to a sign: `(iγ^μ)ᴴ = ±iγ^μ`. -/
theorem mgamma_conjTranspose (μ : Fin 4) :
    (mgamma μ)ᴴ = (if μ = 0 then (-1 : ℂ) else 1) • mgamma μ := by
  ext i j
  have h := congrFun (congrFun (mgammaZ_transpose μ) i) j
  simp only [Matrix.transpose_apply, Matrix.smul_apply, smul_eq_mul] at h
  simp only [mgamma, RingHom.mapMatrix_apply, Matrix.conjTranspose_apply, Matrix.map_apply,
    Matrix.smul_apply, smul_eq_mul, eq_intCast, Complex.star_def]
  rw [h]
  split_ifs <;> push_cast <;> simp

/-- The adjoint of `iγ^μ` as an operator on `ℂ⁴` is `±iγ^μ`. -/
theorem adjoint_mgammaLin (μ : Fin 4) :
    LinearMap.adjoint (mgammaLin μ) = (if μ = 0 then (-1 : ℂ) else 1) • mgammaLin μ := by
  rw [mgammaLin, ← Matrix.toEuclideanLin_conjTranspose_eq_adjoint, mgamma_conjTranspose]
  split_ifs <;> simp []

/-- `toEuclideanLin` turns matrix multiplication into composition. -/
theorem toEuclideanLin_mul4 (A B : Matrix (Fin 4) (Fin 4) ℂ) :
    Matrix.toEuclideanLin (A * B)
      = (Matrix.toEuclideanLin A) ∘ₗ (Matrix.toEuclideanLin B) := by
  ext x i
  simp [Matrix.mulVec_mulVec]

/-- The orthogonal complement of an invariant subspace is invariant. -/
theorem mgammaLin_orthogonal_invariant {W : Submodule ℂ MajoranaSpace}
    (hW : ∀ μ, ∀ x ∈ W, mgammaLin μ x ∈ W) (μ : Fin 4) {y : MajoranaSpace} (hy : y ∈ Wᗮ) :
    mgammaLin μ y ∈ Wᗮ := by
  rw [Submodule.mem_orthogonal]
  intro u hu
  rw [← LinearMap.adjoint_inner_left (mgammaLin μ) y u, adjoint_mgammaLin]
  simp only [LinearMap.smul_apply, inner_smul_left]
  rw [(Submodule.mem_orthogonal W y).mp hy _ (hW μ u hu)]
  ring

/-- **Irreducibility of the concrete Majorana representation.**  The only
subspaces of `ℂ⁴` invariant under all four Majorana matrices are `⊥` and `⊤`.

Together with `mgamma_commutant_scalar` this is the full Schur package for the
fixed `4×4` model, with no `EXTERNAL` input. -/
theorem mgamma_irreducible (W : Submodule ℂ MajoranaSpace)
    (hW : ∀ μ, ∀ x ∈ W, mgammaLin μ x ∈ W) : W = ⊥ ∨ W = ⊤ := by
  set p : MajoranaSpace →ₗ[ℂ] MajoranaSpace :=
    (W.starProjection : MajoranaSpace →L[ℂ] MajoranaSpace).toLinearMap with hp
  have hpself : ∀ x ∈ W, p x = x := fun x hx => Submodule.starProjection_eq_self_iff.mpr hx
  have hpzero : ∀ x ∈ Wᗮ, p x = 0 := by
    intro x hx
    simp [hp, Submodule.starProjection_apply,
      Submodule.orthogonalProjection_mem_subspace_orthogonalComplement_eq_zero hx]
  have hpmem : ∀ x, p x ∈ W := fun x => (W.orthogonalProjection x).2
  have hcomm : ∀ μ, p ∘ₗ mgammaLin μ = mgammaLin μ ∘ₗ p := by
    intro μ
    refine LinearMap.ext fun x => ?_
    have ha : p x ∈ W := hpmem x
    have hb : x - p x ∈ Wᗮ := Submodule.sub_starProjection_mem_orthogonal x
    have hsplit : mgammaLin μ x = mgammaLin μ (p x) + mgammaLin μ (x - p x) := by
      rw [← map_add]; congr 1; abel
    rw [LinearMap.comp_apply, LinearMap.comp_apply, hsplit, map_add,
      hpself _ (hW μ _ ha), hpzero _ (mgammaLin_orthogonal_invariant hW μ hb), add_zero]
  set M : Matrix (Fin 4) (Fin 4) ℂ := Matrix.toEuclideanLin.symm p with hMdef
  have hMp : Matrix.toEuclideanLin M = p := Matrix.toEuclideanLin.apply_symm_apply p
  have hMcomm : ∀ μ, M * mgamma μ = mgamma μ * M := by
    intro μ
    apply Matrix.toEuclideanLin.injective
    rw [toEuclideanLin_mul4, toEuclideanLin_mul4, hMp]
    exact hcomm μ
  have hM := mgamma_commutant_scalar M hMcomm
  have hpx : ∀ x, p x = (M 0 0) • x := by
    intro x
    rw [← hMp, hM]
    simp
  obtain ⟨v, hv⟩ := exists_ne (0 : MajoranaSpace)
  have hidem : (M 0 0) * (M 0 0) = M 0 0 := by
    have h1 : p (p v) = p v := hpself _ (hpmem v)
    rw [hpx, hpx, smul_smul] at h1
    have h2 := sub_eq_zero.mpr h1
    rw [← sub_smul] at h2
    rcases smul_eq_zero.mp h2 with h | h
    · linear_combination h
    · exact absurd h hv
  have hcase : (M 0 0) = 0 ∨ (M 0 0) = 1 := by
    rcases mul_eq_zero.mp (show (M 0 0) * ((M 0 0) - 1) = 0 by linear_combination hidem) with
      h | h
    · exact Or.inl h
    · exact Or.inr (by linear_combination h)
  rcases hcase with h | h
  · left
    rw [Submodule.eq_bot_iff]
    intro x hx
    have hx' := hpself x hx
    rw [hpx, h, zero_smul] at hx'
    exact hx'.symm
  · right
    rw [Submodule.eq_top_iff']
    intro x
    have hx' := hpmem x
    rwa [hpx, h, one_smul] at hx'

end BookProof.ChapterA3

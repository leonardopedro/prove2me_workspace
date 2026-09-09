import Mathlib
import BookProof.ChapterH4
import BookProof.ChapterH6

/-!
# Chapter H7 — the reduced generator is Hermitian, its spectrum is contained,
and online generation is unitary (roadmap §9.2 / §10, continuing `ChapterH6`)

`ChapterH6` proved that the Krylov compression `B = V∗ X V` transports the
Rayleigh quotient and that generation is a *single* `m × m` matrix exponential.
Two structural facts that the QFM online stage relies on were left open there,
and are supplied here.

**1. The reduction is physical.**  If the full generator `X` is self-adjoint,
so is its compression (`compress_isSelfAdjoint`), and the explicit reduced
matrix is Hermitian (`reduceGenerator_isHermitian`).  Consequently every
eigenvalue of the reduced generator is *real* and lies between any two bounds
of the numerical range of `X` (`compression_eigenvalue_mem_numericalRange`):
the low-pass filter can only keep frequencies the full generator already has —
it never manufactures a new one, above *or* below the original band.

**2. The online step conserves probability.**  For a Hermitian reduced
generator `A` and a real time `t`, the propagator `e^{−i t A}` is a unitary
matrix (`generationOperator_mem_unitaryGroup`), so the generated state has the
same `ℓ²` mass as the input (`generation_preserves_l2`) — the four-phase online
generate of `QFM.tex` §10 is norm-preserving, and its Born weights remain a
probability distribution.

## Deliverables

* `compress_isSelfAdjoint`, `reduceGenerator_isHermitian`;
* `compression_rayleigh_real` — the Rayleigh quotient of a self-adjoint
  generator is real;
* `compression_eigenvalue_mem_numericalRange` — **headline**: an eigenvalue of
  the reduced generator is real and inside the numerical range of `X`;
* `generationOperator`, `generationOperator_conjTranspose_mul`,
  `generationOperator_mem_unitaryGroup`;
* `generation_preserves_l2` — **headline**: online generation preserves the
  `ℓ²` mass of the state.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

noncomputable section

open BookProof.ChapterH4 BookProof.ChapterH6

namespace BookProof.ChapterH7

/-! ## The compression of a self-adjoint generator -/

section SelfAdjoint

variable {E F : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

/-- **The compression of a self-adjoint generator is self-adjoint.** -/
theorem compress_isSelfAdjoint (V : F →L[ℂ] E) (X : E →L[ℂ] E) (hX : IsSelfAdjoint X) :
    IsSelfAdjoint (compress V X) := by
  have hadj : ContinuousLinearMap.adjoint X = X :=
    (ContinuousLinearMap.star_eq_adjoint X).symm.trans hX
  have hstar : star (compress V X) = compress V X := by
    rw [ContinuousLinearMap.star_eq_adjoint, compress, ContinuousLinearMap.adjoint_comp,
      ContinuousLinearMap.adjoint_comp, ContinuousLinearMap.adjoint_adjoint, hadj,
      ContinuousLinearMap.comp_assoc]
  exact hstar

/-- The Rayleigh quotient of a self-adjoint operator is real. -/
theorem inner_self_real (X : E →L[ℂ] E) (hX : IsSelfAdjoint X) (x : E) :
    (inner ℂ x (X x) : ℂ).im = 0 := by
  have hadj : ContinuousLinearMap.adjoint X = X :=
    (ContinuousLinearMap.star_eq_adjoint X).symm.trans hX
  have h : (starRingEnd ℂ) (inner ℂ x (X x) : ℂ) = (inner ℂ x (X x) : ℂ) := by
    rw [inner_conj_symm]
    calc (inner ℂ (X x) x : ℂ) = inner ℂ x ((ContinuousLinearMap.adjoint X) x) :=
          (ContinuousLinearMap.adjoint_inner_right X x x).symm
      _ = inner ℂ x (X x) := by rw [hadj]
  have := Complex.conj_eq_iff_im.mp h
  exact this

/-- The Rayleigh quotient of the *compressed* generator is real as well. -/
theorem compression_rayleigh_real (V : F →L[ℂ] E) (X : E →L[ℂ] E)
    (hX : IsSelfAdjoint X) (y : F) : (inner ℂ y (compress V X y) : ℂ).im = 0 := by
  rw [krylov_rayleigh_transfer]
  exact inner_self_real X hX (V y)

/-- **Headline.**  An eigenvalue of the reduced generator of a self-adjoint `X`
is *real*, and lies between any two bounds `a ≤ ⟪x, Xx⟫ ≤ b` of the numerical
range of `X` on unit vectors: the Krylov low-pass filter retains frequencies of
`X` and creates none. -/
theorem compression_eigenvalue_mem_numericalRange (V : F →L[ℂ] E) (X : E →L[ℂ] E)
    (hX : IsSelfAdjoint X) (hViso : ∀ x : F, ‖V x‖ = ‖x‖)
    {lam : ℂ} {y : F} (hy : ‖y‖ = 1) (heig : compress V X y = lam • y)
    {a b : ℝ} (hlow : ∀ x : E, ‖x‖ = 1 → a ≤ (inner ℂ x (X x) : ℂ).re)
    (hhigh : ∀ x : E, ‖x‖ = 1 → (inner ℂ x (X x) : ℂ).re ≤ b) :
    lam.im = 0 ∧ a ≤ lam.re ∧ lam.re ≤ b := by
  have hval : lam = inner ℂ (V y) (X (V y)) :=
    (krylovRetainsDominantSpectrum V X hViso lam y hy heig).1
  have hVy : ‖V y‖ = 1 := by rw [hViso, hy]
  refine ⟨?_, ?_, ?_⟩
  · rw [hval]; exact inner_self_real X hX (V y)
  · rw [hval]; exact hlow _ hVy
  · rw [hval]; exact hhigh _ hVy

end SelfAdjoint

/-! ## The reduced matrix is Hermitian -/

section Reduced

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

/-- The explicit `m × m` reduced generator of a self-adjoint `X` is a Hermitian
matrix. -/
theorem reduceGenerator_isHermitian (m : ℕ) (V : EuclideanSpace ℂ (Fin m) →L[ℂ] E)
    (X : E →L[ℂ] E) (hX : IsSelfAdjoint X) :
    (reduceGenerator m V X).IsHermitian := by
  have hadj : ContinuousLinearMap.adjoint X = X :=
    (ContinuousLinearMap.star_eq_adjoint X).symm.trans hX
  ext i j
  have h1 : (inner ℂ (X (V (EuclideanSpace.single i (1 : ℂ))))
        (V (EuclideanSpace.single j (1 : ℂ))) : ℂ)
      = inner ℂ (V (EuclideanSpace.single i (1 : ℂ)))
          (X (V (EuclideanSpace.single j (1 : ℂ)))) := by
    conv_lhs => rw [← hadj]
    exact ContinuousLinearMap.adjoint_inner_left X _ _
  simp only [Matrix.conjTranspose_apply, reduceGenerator, Matrix.of_apply, RCLike.star_def]
  rw [inner_conj_symm]
  exact h1

end Reduced

/-! ## Online generation is unitary -/

section Unitary

open Matrix

variable {m : ℕ}

/-- The **generation propagator** `e^{−i t A}` of the reduced generator `A` at
real time `t`. -/
def generationOperator (A : Matrix (Fin m) (Fin m) ℂ) (t : ℝ) : Matrix (Fin m) (Fin m) ℂ :=
  NormedSpace.exp ((-Complex.I * (t : ℂ)) • A)

theorem generatedState_eq_generationOperator (A : Matrix (Fin m) (Fin m) ℂ) (t : ℝ)
    (psi0 : Fin m → ℂ) :
    generatedState A (t : ℂ) psi0 = (generationOperator A t).mulVec psi0 := rfl

/-- The conjugate transpose of the propagator is the propagator run backwards. -/
theorem generationOperator_conjTranspose (A : Matrix (Fin m) (Fin m) ℂ) (t : ℝ)
    (hA : A.IsHermitian) :
    (generationOperator A t)ᴴ = NormedSpace.exp ((Complex.I * (t : ℂ)) • A) := by
  rw [generationOperator, ← Matrix.exp_conjTranspose]
  congr 1
  rw [Matrix.conjTranspose_smul, hA.eq]
  congr 1
  simp [Complex.conj_I]

/-- **The propagator is unitary.** -/
theorem generationOperator_conjTranspose_mul (A : Matrix (Fin m) (Fin m) ℂ) (t : ℝ)
    (hA : A.IsHermitian) :
    (generationOperator A t)ᴴ * generationOperator A t = 1 := by
  have hcomm : Commute ((Complex.I * (t : ℂ)) • A) ((-Complex.I * (t : ℂ)) • A) := by
    unfold Commute SemiconjBy
    rw [Matrix.smul_mul, Matrix.mul_smul, Matrix.smul_mul, Matrix.mul_smul, smul_smul, smul_smul,
      mul_comm (Complex.I * (t : ℂ)) (-Complex.I * (t : ℂ))]
  rw [generationOperator_conjTranspose A t hA, generationOperator,
    ← Matrix.exp_add_of_commute _ _ hcomm]
  rw [← add_smul]
  rw [show (Complex.I * (t : ℂ)) + (-Complex.I * (t : ℂ)) = 0 by ring]
  simp

theorem generationOperator_mem_unitaryGroup (A : Matrix (Fin m) (Fin m) ℂ) (t : ℝ)
    (hA : A.IsHermitian) : generationOperator A t ∈ Matrix.unitaryGroup (Fin m) ℂ := by
  have h := generationOperator_conjTranspose_mul A t hA
  refine ⟨?_, ?_⟩
  · simpa [Matrix.star_eq_conjTranspose] using h
  · have hinv : (generationOperator A t) * (generationOperator A t)ᴴ = 1 :=
      (mul_eq_one_comm_of_card_eq (Fin m) (Fin m) ℂ rfl).mp h
    simpa [Matrix.star_eq_conjTranspose] using hinv

/-- **Headline.**  Online generation conserves probability: the `ℓ²` mass of the
generated state equals that of the input state. -/
theorem generation_preserves_l2 (A : Matrix (Fin m) (Fin m) ℂ) (t : ℝ)
    (hA : A.IsHermitian) (psi0 : Fin m → ℂ) :
    ∑ i, Complex.normSq (generatedState A (t : ℂ) psi0 i) = ∑ i, Complex.normSq (psi0 i) := by
  have hU := generationOperator_conjTranspose_mul A t hA
  have key : (star ((generationOperator A t).mulVec psi0)) ⬝ᵥ
      ((generationOperator A t).mulVec psi0) = (star psi0) ⬝ᵥ psi0 := by
    rw [Matrix.star_mulVec, ← Matrix.dotProduct_mulVec, Matrix.mulVec_mulVec, hU,
      Matrix.one_mulVec]
  have hcast : ∀ v : Fin m → ℂ, (star v) ⬝ᵥ v = ((∑ i, Complex.normSq (v i) : ℝ) : ℂ) := by
    intro v
    simp only [dotProduct, Pi.star_apply, RCLike.star_def, Complex.ofReal_sum]
    exact Finset.sum_congr rfl fun i _ => (Complex.normSq_eq_conj_mul_self).symm
  rw [generatedState_eq_generationOperator]
  have := key
  rw [hcast, hcast] at this
  exact_mod_cast this

end Unitary

end BookProof.ChapterH7

end

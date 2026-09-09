import Mathlib











open scoped BigOperators


noncomputable section





variable {E F : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

namespace BookProof.ChapterH4

/-- The **SIRK compression** `B := V∗ X V` of an operator `X` to the finite
subspace embedded by the isometry `V`.  With `V = Vₘ` the orthonormal Krylov
basis and `X = Xₘ` the shift-invert resolvent, this is exactly the paper's
`Hₘ Kₘ⁻¹` (eq. 10). -/
def compress (V : F →L[ℂ] E) (X : E →L[ℂ] E) : F →L[ℂ] F :=
  V.adjoint.comp (X.comp V)

end BookProof.ChapterH4











noncomputable section


open BookProof.ChapterH4
open Filter Topology NormedSpace

variable {E F : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

namespace BookProof.ChapterSirkDiffusiveDecay

/-- The parabolic (heat) semigroup `e^{−tA}` of a bounded generator. -/
def heatFlow (A : E →L[ℂ] E) (t : ℝ) : E →L[ℂ] E := exp ((-t) • A)

/-- **Coercivity** of a generator with rate `μ`: `μ‖x‖² ≤ Re⟪x, A x⟫`.  For the
parabolic part of the Navier–Stokes Lagrangian generator this is the mode-wise
bound with `μ = νk²`. -/
def IsCoercive (A : E →L[ℂ] E) (mu : ℝ) : Prop :=
  ∀ x : E, mu * ‖x‖ ^ 2 ≤ (inner ℂ x (A x) : ℂ).re

end BookProof.ChapterSirkDiffusiveDecay


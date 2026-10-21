-- Generated from ChapterNavierStokesGaugeY2.lean — solution of BookProof.NavierStokesGaugeY2.commutator_leibniz
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY2
open BookProof.NavierStokesGaugeY2




open MvPolynomial BookProof.NavierStokesGaugeY

set_option maxHeartbeats 1000000 in
theorem solution (D₁ D₂ : Module.End ℂ NSAlg)
    (h₁ : ∀ p q, D₁ (p * q) = D₁ p * q + p * D₁ q)
    (h₂ : ∀ p q, D₂ (p * q) = D₂ p * q + p * D₂ q) (p q : NSAlg) :
    ⁅D₁, D₂⁆ (p * q) = ⁅D₁, D₂⁆ p * q + p * ⁅D₁, D₂⁆ q := by

  simp only [Ring.lie_def, LinearMap.sub_apply, Module.End.mul_apply, h₁, h₂, map_add]
  ring

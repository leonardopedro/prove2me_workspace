-- Generated from ChapterNavierStokesGaugeY2.lean — theorem BookProof.NavierStokesGaugeY2.commutator_leibniz
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY2
import Definitions.Def_ChapterNavierStokesGaugeY
open BookProof.NavierStokesGaugeY
open BookProof.NavierStokesGaugeY2



open MvPolynomial BookProof.NavierStokesGaugeY

theorem BookProof.NavierStokesGaugeY2.commutator_leibniz (D₁ D₂ : Module.End ℂ NSAlg)
    (h₁ : ∀ p q, D₁ (p * q) = D₁ p * q + p * D₁ q)
    (h₂ : ∀ p q, D₂ (p * q) = D₂ p * q + p * D₂ q) (p q : NSAlg) :
    ⁅D₁, D₂⁆ (p * q) = ⁅D₁, D₂⁆ p * q + p * ⁅D₁, D₂⁆ q := by sorry

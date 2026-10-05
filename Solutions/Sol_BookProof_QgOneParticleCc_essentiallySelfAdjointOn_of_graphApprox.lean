-- Generated from ChapterQgOneParticleCcEsa.lean — solution of BookProof.QgOneParticleCc.essentiallySelfAdjointOn_of_graphApprox
import Mathlib
import Definitions.Def_ChapterQgOneParticleCcEsa
import Theorems.Thm_BookProof_QgOneParticleCc_deficiencyTrivialAt_of_graphApprox
open BookProof.QgOneParticleCc




open MeasureTheory SchwartzMap Complex MvPolynomial
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.HermiteQuadraticEsa
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.DirectSumEsa

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution {D₁ D₂ : Submodule ℂ F}
    (T₁ : D₁ →ₗ[ℂ] F) (T₂ : D₂ →ₗ[ℂ] F)
    (happrox : ∀ (x : D₁) (ε : ℝ), 0 < ε →
      ∃ y : D₂, ‖(y : F) - (x : F)‖ < ε ∧ ‖T₂ y - T₁ x‖ < ε)
    (h₁ : EssentiallySelfAdjointOn D₁ T₁) :
    EssentiallySelfAdjointOn D₂ T₂ :=
  ⟨deficiencyTrivialAt_of_graphApprox T₁ T₂ happrox h₁.1,
      deficiencyTrivialAt_of_graphApprox T₁ T₂ happrox h₁.2⟩

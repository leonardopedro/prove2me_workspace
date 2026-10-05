-- Generated from ChapterQgOneParticleCcEsa.lean — theorem BookProof.QgOneParticleCc.essentiallySelfAdjointOn_of_graphApprox
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Definitions.Def_ChapterHermiteQuadraticEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterDirectSumEsa
import Mathlib
import Definitions.Def_ChapterQgOneParticleCcEsa
import Definitions.Def_ChapterFarisLavineCore
open BookProof.QgOneParticleCc

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]



open MeasureTheory SchwartzMap Complex MvPolynomial
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.HermiteQuadraticEsa
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.DirectSumEsa

noncomputable section

theorem BookProof.QgOneParticleCc.essentiallySelfAdjointOn_of_graphApprox {D₁ D₂ : Submodule ℂ F}
    (T₁ : D₁ →ₗ[ℂ] F) (T₂ : D₂ →ₗ[ℂ] F)
    (happrox : ∀ (x : D₁) (ε : ℝ), 0 < ε →
      ∃ y : D₂, ‖(y : F) - (x : F)‖ < ε ∧ ‖T₂ y - T₁ x‖ < ε)
    (h₁ : EssentiallySelfAdjointOn D₁ T₁) :
    EssentiallySelfAdjointOn D₂ T₂ := by sorry

-- Generated from ChapterWallEsaSemibounded.lean — theorem BookProof.WallEsaSemibounded.kinCcR_quadratic_form
import Mathlib
import Definitions.Def_ChapterWallEsaSemibounded
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterScalaronWallEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStrichartzWave
open BookProof.WallEsaSemibounded










open MeasureTheory SchwartzMap
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

theorem BookProof.WallEsaSemibounded.kinCcR_quadratic_form (f : ccSchwartz ℝ) :
    (inner ℂ (kinCcR (ccEquiv ℝ f))
        ((ccEquiv ℝ f : ccDomain ℝ) : Lp ℂ 2 (volume : Measure ℝ)) : ℂ)
      = ((∫ x, ‖deriv ((f : 𝓢(ℝ, ℂ)) : ℝ → ℂ) x‖ ^ 2 : ℝ) : ℂ) := by sorry

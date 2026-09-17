-- Generated from ChapterWallEsaSemibounded.lean — theorem BookProof.WallEsaSemibounded.inner_toLp_self
import Mathlib
import Definitions.Def_ChapterWallEsaSemibounded
open BookProof.WallEsaSemibounded










open MeasureTheory SchwartzMap
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa BookProof.WallEsaBddBelow

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

theorem BookProof.WallEsaSemibounded.inner_toLp_self (g : 𝓢(ℝ, ℂ)) :
    (inner ℂ (g.toLp 2 (volume : Measure ℝ)) (g.toLp 2 (volume : Measure ℝ)) : ℂ)
      = ((∫ x, ‖g x‖ ^ 2 : ℝ) : ℂ) := by sorry

-- Generated from ChapterWallEsaSemibounded.lean — theorem BookProof.WallEsaSemibounded.ccEquiv_norm_sq
import Mathlib
import Definitions.Def_ChapterWallEsaSemibounded
import Definitions.Def_BookProof.ChapterClosureUniqueness

open BookProof.WallEsaSemibounded










open MeasureTheory SchwartzMap
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa BookProof.WallEsaBddBelow

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

theorem BookProof.WallEsaSemibounded.ccEquiv_norm_sq (f : ccSchwartz ℝ) :
    ‖((ccEquiv ℝ f : ccDomain ℝ) : Lp ℂ 2 (volume : Measure ℝ))‖ ^ 2
      = ∫ x, ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 := by sorry

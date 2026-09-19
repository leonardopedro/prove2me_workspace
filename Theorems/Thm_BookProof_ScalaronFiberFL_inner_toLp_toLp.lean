-- Generated from ChapterScalaronFiberFL.lean — theorem BookProof.ScalaronFiberFL.inner_toLp_toLp
import Mathlib
import Definitions.Def_ChapterScalaronFiberFL
open BookProof.ScalaronFiberFL



open MeasureTheory SchwartzMap
open BookProof.StrichartzWave
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallEsaSemibounded BookProof.WallEsaBddBelow
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.SchrodingerCutoff BookProof.FriedrichsExtension

noncomputable section

theorem BookProof.ScalaronFiberFL.inner_toLp_toLp (g h : 𝓢(ℝ, ℂ)) :
    (inner ℂ (g.toLp 2 (volume : Measure ℝ)) (h.toLp 2 (volume : Measure ℝ)) : ℂ)
      = ∫ x, (starRingEnd ℂ) (g x) * h x := by sorry

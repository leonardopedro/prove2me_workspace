-- Generated from ChapterIrreversibleDynamics.lean — theorem BookProof.IrreversibleDynamics.dissipative_volume_Icc
import Mathlib
import Definitions.Def_ChapterIrreversibleDynamics
open BookProof.IrreversibleDynamics



open MeasureTheory Function Set
open scoped ENNReal

theorem BookProof.IrreversibleDynamics.dissipative_volume_Icc (a b : ℝ) :
    volume (dissipative '' Set.Icc a b) = ENNReal.ofReal ((b - a) / 2) := by sorry

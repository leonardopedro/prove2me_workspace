-- Generated from ChapterIrreversibleDynamics.lean — theorem BookProof.IrreversibleDynamics.dissipative_nonsingular_Icc
import Mathlib
import Definitions.Def_ChapterIrreversibleDynamics
open BookProof.IrreversibleDynamics



open MeasureTheory Function Set
open scoped ENNReal

theorem BookProof.IrreversibleDynamics.dissipative_nonsingular_Icc {a b : ℝ} (h : a < b) :
    0 < volume (dissipative '' Set.Icc a b) := by sorry

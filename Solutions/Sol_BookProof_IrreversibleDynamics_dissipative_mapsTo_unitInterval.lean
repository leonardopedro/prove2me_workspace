-- Generated from ChapterIrreversibleDynamics.lean — solution of BookProof.IrreversibleDynamics.dissipative_mapsTo_unitInterval
import Mathlib
import Definitions.Def_ChapterIrreversibleDynamics
open BookProof.IrreversibleDynamics




open MeasureTheory Function Set
open scoped ENNReal

set_option maxHeartbeats 1000000 in
theorem solution :
    Set.MapsTo dissipative (Set.Icc (0 : ℝ) 1) (Set.Icc (0 : ℝ) 1) := by

  intro x hx
  simp only [Set.mem_Icc, dissipative_apply] at hx ⊢
  constructor <;> linarith [hx.1, hx.2]

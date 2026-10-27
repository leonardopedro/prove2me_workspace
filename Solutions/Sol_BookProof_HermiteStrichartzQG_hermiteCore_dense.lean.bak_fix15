-- Generated from ChapterStrichartzHermiteQG.lean — solution of BookProof.HermiteStrichartzQG.hermiteCore_dense
import Mathlib
import Definitions.Def_ChapterStrichartzHermiteQG
open BookProof.HermiteStrichartzQG




open MeasureTheory BookProof.HermiteCore BookProof.FarisLavine
open BookProof.QuantumGravityDensitized

set_option maxHeartbeats 1000000 in
theorem solution : Dense (hermiteCore : Set L2R) := by

  rw [Submodule.dense_iff_topologicalClosure_eq_top]
  exact top_le_iff.mp hermiteLp_span_dense

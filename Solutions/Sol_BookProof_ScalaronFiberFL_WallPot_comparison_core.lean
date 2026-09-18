-- Generated from ChapterScalaronFiberFL.lean — solution of BookProof.ScalaronFiberFL.WallPot.comparison_core
import Mathlib
import Definitions.Def_ChapterScalaronFiberFL
import Theorems.Thm_BookProof_ScalaronEsa_ccDomain_dense
open BookProof.ScalaronFiberFL
open BookProof.ScalaronFiberFL.WallPot




open MeasureTheory SchwartzMap
open BookProof.StrichartzWave
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.SchrodingerCutoff BookProof.FriedrichsExtension

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (p : ccDomain ℝ) (h : (p : L2R) ∈ (W.comparison s hs).dom) :
    (W.comparison s hs).op ⟨(p : L2R), h⟩ = W.ham s p := (friedrichsComparison_extends (W.posSym s hs) ccDomain_dense p).choose_spec

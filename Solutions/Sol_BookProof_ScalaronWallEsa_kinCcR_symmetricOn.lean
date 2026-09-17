-- Generated from ChapterScalaronWallEsa.lean — solution of BookProof.ScalaronWallEsa.kinCcR_symmetricOn
import Mathlib
import Definitions.Def_ChapterScalaronWallEsa
import Theorems.Thm_BookProof_StrichartzWave_constCoeffOp_symmetric
open BookProof.ScalaronWallEsa













open MeasureTheory SchwartzMap Set
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.Starobinsky BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent
open BookProof.WeakSecondDeriv

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : SymmetricOn (ccDomain ℝ) kinCcR := symmetricOn_inclusion _ _ (constCoeffOp_symmetric _ _ _)

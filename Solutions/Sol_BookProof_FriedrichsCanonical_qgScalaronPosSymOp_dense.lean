-- Generated from ChapterFriedrichsCanonical.lean — solution of BookProof.FriedrichsCanonical.qgScalaronPosSymOp_dense
import Mathlib
import Definitions.Def_ChapterFriedrichsCanonical
open BookProof.FriedrichsCanonical




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.FriedrichsExtension BookProof.FriedrichsExtension.FormDom

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution (M alpha : ℝ) (hM : 0 < M) (halpha : 0 < alpha) :
    Dense (((qgScalaronPosSymOp M alpha hM halpha).dom : Submodule ℂ (L2d 1)) : Set (L2d 1)) := polyGaussCore_dense

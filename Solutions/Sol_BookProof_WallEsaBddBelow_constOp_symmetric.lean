-- Generated from ChapterWallEsaBddBelow.lean — solution of BookProof.WallEsaBddBelow.constOp_symmetric
import Mathlib
import Definitions.Def_ChapterWallEsaBddBelow
open BookProof.WallEsaBddBelow




open MeasureTheory SchwartzMap Set
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.KatoRellich BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (c : ℝ) (x y : Lp ℂ 2 (volume : Measure ℝ)) :
    (inner ℂ (constOp c x) y : ℂ) = inner ℂ x (constOp c y) := by

  simp only [constOp, ContinuousLinearMap.smul_apply, ContinuousLinearMap.id_apply,
    inner_smul_left, inner_smul_right, Complex.conj_ofReal]

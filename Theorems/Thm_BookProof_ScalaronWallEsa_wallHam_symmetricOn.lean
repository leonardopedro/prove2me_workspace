-- Generated from ChapterScalaronWallEsa.lean — theorem BookProof.ScalaronWallEsa.wallHam_symmetricOn
import Mathlib
import Definitions.Def_ChapterScalaronWallEsa
open BookProof.ScalaronWallEsa



open MeasureTheory SchwartzMap Set
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.Starobinsky BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent
open BookProof.WeakSecondDeriv

noncomputable section

 + opCc V hV

theorem BookProof.ScalaronWallEsa.wallHam_symmetricOn : SymmetricOn (ccDomain ℝ) kinCcR :=
  symmetricOn_inclusion _ _ (constCoeffOp_symmetric _ _ _)

theorem wa := by sorry

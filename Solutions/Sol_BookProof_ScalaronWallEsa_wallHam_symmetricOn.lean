-- Generated from ChapterScalaronWallEsa.lean — solution of BookProof.ScalaronWallEsa.wallHam_symmetricOn
import Mathlib
import Definitions.Def_ChapterScalaronWallEsa
import Theorems.Thm_BookProof_ScalaronEsa_smoothPotential_symmetric
import Theorems.Thm_BookProof_ScalaronWallEsa_kinCcR_symmetricOn
open BookProof.ScalaronWallEsa




open MeasureTheory SchwartzMap Set
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.Starobinsky BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent
open BookProof.WeakSecondDeriv

noncomputable section

set_option maxHeartbeats 1000000 in
 + opCc V hV

theorem solution : SymmetricOn (ccDomain ℝ) kinCcR :=
  symmetricOn_inclusion _ _ (constCoeffOp_symmetric _ _ _)

theorem wa :=
  llHam_symmetricOn (V : ℝ → ℝ) (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V) :
      SymmetricOn (ccDomain ℝ) (wallHam V hV) := by
    intro x y
    have h1 := kinCcR_symmetricOn x y
    have h2 :=

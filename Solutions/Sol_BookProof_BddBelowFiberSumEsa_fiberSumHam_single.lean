-- Generated from ChapterBddBelowFiberSumEsa.lean — solution of BookProof.BddBelowFiberSumEsa.fiberSumHam_single
import Mathlib
import Definitions.Def_ChapterBddBelowFiberSumEsa
import Theorems.Thm_BookProof_DirectSumEsa_dsOp_single
import Theorems.Thm_BookProof_DirectSumEsa_single_mem_dsCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterBddBelowWallEsa
import Definitions.Def_ChapterWallEsaSemibounded
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterScalaronWallEsa
open BookProof.BddBelowFiberSumEsa




open MeasureTheory
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.BddBelowWallEsa BookProof.WallEsaSemibounded BookProof.DirectSumEsa
open BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa

noncomputable section

variable {ι : Type*}

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution [DecidableEq ι] (V : ι → ℝ → ℝ)
    (hV : ∀ i, ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (V i)) (i : ι) (u : ccDomain ℝ) :
    fiberSumHam V hV ⟨lp.single 2 i (u : Lp ℂ 2 (volume : Measure ℝ)),
        single_mem_dsCore (D := fun _ : ι => ccDomain ℝ) i u⟩
      = lp.single 2 i (wallHam (V i) (hV i) u) := dsOp_single (D := fun _ : ι => ccDomain ℝ) (fun i => wallHam (V i) (hV i)) i u

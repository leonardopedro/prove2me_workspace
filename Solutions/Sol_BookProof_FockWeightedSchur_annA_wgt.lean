-- Generated from ChapterFockWeightedSchurEsa.lean — solution of BookProof.FockWeightedSchur.annA_wgt
import Mathlib
import Definitions.Def_ChapterFockWeightedSchurEsa
import Theorems.Thm_BookProof_FockWeightedSchur_wSym_up
import Theorems.Thm_BookProof_FockWeightedSchur_wgt_apply
open BookProof.FockWeightedSchur














open BookProof.FockSecondQuantization BookProof.CoreBounds BookProof.FockSchur
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section




variable {w : ℕ → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (j : ℕ) (u : FockAlg) :
    annA j (wgt w u) = wgt w (annA j u) + ((w j ^ 2 : ℝ) : ℂ) • annA j u := by

  refine Finsupp.ext fun α => ?_
  rw [annA_apply, wgt_apply, Finsupp.add_apply, wgt_apply, annA_apply, Finsupp.smul_apply,
    annA_apply, smul_eq_mul, wSym_up]
  push_cast
  ring

-- Generated from ChapterNsFourierElimination.lean — solution of BookProof.NsFullEuler.nsRedFockCore_le_friedDom
import Mathlib
import Definitions.Def_ChapterNsFourierElimination
import Theorems.Thm_BookProof_NsFullEuler_polyGaussCore_le_redFriedDom
import Theorems.Thm_BookProof_NsFullEuler_redFried_op_core
open BookProof.NsFullEuler




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.QgOuterFockFL

noncomputable section

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (nu : ℝ) (k : Fin 3 → ℝ) :
    nsRedFockCore ≤ (nsRedOuterComparison nu k).dom := by

  intro x hx
  refine ⟨fun n => polyGaussCore_le_redFriedDom nu k n (hx.2 n), ?_⟩
  have hfun : (fun n : ℕ => opTot (redFried nu k n).op ((x : nsRedFockSpace) n))
      = fun n : ℕ =>
        (redHam nu k n ⟨(x : nsRedFockSpace) n, hx.2 n⟩ : L2d (n * 6)) := by
    funext n
    rw [opTot_of_mem _ (polyGaussCore_le_redFriedDom nu k n (hx.2 n)),
      redFried_op_core nu k n ⟨(x : nsRedFockSpace) n, hx.2 n⟩]
  rw [hfun]
  refine memLp_of_finite_support (Set.Finite.subset hx.1 fun n hn => ?_)
  simp only [Set.mem_setOf_eq] at hn ⊢
  intro h0
  refine hn ?_
  have hz : (⟨(x : nsRedFockSpace) n, hx.2 n⟩ : polyGaussCore (d := n * 6)) = 0 :=
    Subtype.ext h0
  rw [hz, map_zero]

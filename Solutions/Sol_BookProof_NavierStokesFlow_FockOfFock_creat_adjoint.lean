-- Generated from ChapterNavierStokesFockSpace.lean — solution of BookProof.NavierStokesFlow.FockOfFock.creat_adjoint
import Mathlib
import Definitions.Def_ChapterNavierStokesFockSpace
import Theorems.Thm_BookProof_NavierStokesFlow_FockOfFock_add_single_sub_single
import Theorems.Thm_BookProof_NavierStokesFlow_FockOfFock_annih_coe
import Theorems.Thm_BookProof_NavierStokesFlow_FockOfFock_creat_coe
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockOfFock









open FullEsa



variable {ι : Type*}














variable {ι : Type*}











variable {M : Type*} [DecidableEq M]

set_option maxHeartbeats 1000000 in
theorem solution (m : M) (v w : FockDom M) :
    (inner ℂ ((creat m v : FockDom M) : FockL2 M) ((w : FockDom M) : FockL2 M) : ℂ)
      = inner ℂ ((v : FockDom M) : FockL2 M) ((annih m w : FockDom M) : FockL2 M) := by

  classical
  set V : Conf M → ℂ := ((v : FockL2 M) : Conf M → ℂ) with hV
  set W : Conf M → ℂ := ((w : FockL2 M) : Conf M → ℂ) with hW
  set F : Conf M → ℂ :=
    fun n => (Real.sqrt (n m) : ℂ) * (starRingEnd ℂ) (V (n - Finsupp.single m 1)) * W n with hF
  have hleft : (inner ℂ ((creat m v : FockDom M) : FockL2 M) ((w : FockDom M) : FockL2 M) : ℂ)
      = ∑' n : Conf M, F n := by
    rw [lp.inner_eq_tsum]
    refine tsum_congr fun n => ?_
    simp only [RCLike.inner_apply, creat_coe, hF, hV, hW, map_mul, Complex.conj_ofReal]
    ring
  have hright : (inner ℂ ((v : FockDom M) : FockL2 M) ((annih m w : FockDom M) : FockL2 M) : ℂ)
      = ∑' n : Conf M, F (n + Finsupp.single m 1) := by
    rw [lp.inner_eq_tsum]
    refine tsum_congr fun n => ?_
    have hm : ((n + Finsupp.single m 1 : Conf M) m : ℝ) = (n m : ℝ) + 1 := by push_cast; simp
    simp only [RCLike.inner_apply, annih_coe, hF, hV, hW, add_single_sub_single, hm]
    ring
  have hsupp : Function.support F ⊆ Set.range fun n : Conf M => n + Finsupp.single m 1 := by
    intro n hn
    simp only [Function.mem_support, hF] at hn
    have hpos : 1 ≤ n m := by
      by_contra hlt
      have hz : n m = 0 := by omega
      exact hn (by simp [hz])
    exact ⟨n - Finsupp.single m 1, sub_single_add_single hpos⟩
  rw [hleft, hright, (add_left_injective (Finsupp.single m 1)).tsum_eq hsupp]

-- Generated from ChapterNavierStokesFockSpace.lean — solution of BookProof.NavierStokesFlow.FockOfFock.lpFiniteModes_sum_repr
import Mathlib
import Definitions.Def_ChapterNavierStokesFockSpace
import Theorems.Thm_BookProof_NavierStokesFlow_FockOfFock_lpBasis_coe
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockOfFock









open FullEsa



variable {ι : Type*}














variable {ι : Type*}











variable {M : Type*} [DecidableEq M]

set_option maxHeartbeats 1000000 in
theorem solution {ι : Type*} [DecidableEq ι] (f : lpFiniteModes ι) :
    f = ∑ i ∈ f.2.toFinset, (((f : lp (fun _ : ι => ℂ) 2) : ι → ℂ) i) • lpBasis i := by

  ext j
  have hcoe : (((∑ i ∈ f.2.toFinset, (((f : lp (fun _ : ι => ℂ) 2) : ι → ℂ) i) • lpBasis i :
      lpFiniteModes ι) : lp (fun _ : ι => ℂ) 2) : ι → ℂ) j
      = ∑ i ∈ f.2.toFinset,
          (((f : lp (fun _ : ι => ℂ) 2) : ι → ℂ) i) * (if j = i then 1 else 0) := by
    classical
    induction f.2.toFinset using Finset.induction with
    | empty => simp
    | insert a s ha ih =>
        rw [Finset.sum_insert ha, Finset.sum_insert ha]
        simp only [Submodule.coe_add, lp.coeFn_add, Pi.add_apply, Submodule.coe_smul,
          lp.coeFn_smul, Pi.smul_apply, smul_eq_mul, lpBasis_coe] at *
        rw [ih]
  rw [hcoe]
  by_cases hj : j ∈ f.2.toFinset
  · rw [Finset.sum_eq_single j]
    · simp
    · intro b _ hb; simp [Ne.symm hb]
    · intro hcon; exact absurd hj hcon
  · have hzero : ((f : lp (fun _ : ι => ℂ) 2) : ι → ℂ) j = 0 := by
      by_contra hne
      exact hj (by simpa [Set.Finite.mem_toFinset, Function.mem_support] using hne)
    rw [hzero]
    refine (Finset.sum_eq_zero fun i hi => ?_).symm
    by_cases hij : j = i
    · exact absurd (hij ▸ hi) hj
    · simp [hij]

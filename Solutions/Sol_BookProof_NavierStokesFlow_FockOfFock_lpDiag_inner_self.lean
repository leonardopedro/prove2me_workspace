-- Generated from ChapterNavierStokesFockEsa.lean — solution of BookProof.NavierStokesFlow.FockOfFock.lpDiag_inner_self
import Mathlib
import Definitions.Def_ChapterNavierStokesFockEsa
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesFockSpace
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Theorems.Thm_BookProof_NavierStokesFlow_FockOfFock_lpDiag_coe
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockOfFock



open MeasureTheory



open FullEsa LagrangianEsa

variable {M : Type*} [DecidableEq M]
variable {M : Type*} [DecidableEq M] {Ω : Type*} [MeasurableSpace Ω]


@[simp] private theorem lpDiag_coe (c : ι → ℝ) (f : lpFiniteModes ι) (i : ι) :
    (((lpDiag c f : lpFiniteModes ι) : lp (fun _ : ι => ℂ) 2) : ι → ℂ) i
      = (c i : ℂ) * ((f : lp (fun _ : ι => ℂ) 2) : ι → ℂ) i := rfl

set_option maxHeartbeats 1000000 in

theorem solution {ι : Type*} (c : ι → ℝ) (v : lpFiniteModes ι) :
    (inner ℂ ((v : lp (fun _ : ι => ℂ) 2))
        (((lpDiag c v : lpFiniteModes ι) : lp (fun _ : ι => ℂ) 2)) : ℂ)
      = ((∑ i ∈ v.2.toFinset, c i * ‖((v : lp (fun _ : ι => ℂ) 2) : ι → ℂ) i‖ ^ 2 : ℝ) : ℂ) := by
  classical
  rw [lp.inner_eq_tsum]
  have hterm : ∀ i : ι,
      (inner ℂ (((v : lp (fun _ : ι => ℂ) 2) : ι → ℂ) i)
        ((((lpDiag c v : lpFiniteModes ι) : lp (fun _ : ι => ℂ) 2) : ι → ℂ) i) : ℂ)
      = ((c i * ‖((v : lp (fun _ : ι => ℂ) 2) : ι → ℂ) i‖ ^ 2 : ℝ) : ℂ) := by
    intro i
    have hz := Complex.mul_conj' (((v : lp (fun _ : ι => ℂ) 2) : ι → ℂ) i)
    simp only [RCLike.inner_apply, lpDiag_coe]
    push_cast
    linear_combination (c i : ℂ) * hz
  rw [tsum_congr hterm, tsum_eq_sum (s := v.2.toFinset) ?_]
  · push_cast
    rfl
  · intro i hi
    have hzero : ((v : lp (fun _ : ι => ℂ) 2) : ι → ℂ) i = 0 := by
      by_contra hne
      have h1 : i ∈ v.2.toFinset ↔
          i ∈ Function.support ((v : lp (fun _ : ι => ℂ) 2) : ι → ℂ) :=
        Set.Finite.mem_toFinset v.2
      exact hi (h1.mpr (Iff.mpr Function.mem_support hne))
    simp [hzero]

omit [DecidableEq M] in

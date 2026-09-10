-- Generated from ChapterNavierStokesSecondQuant.lean — solution of BookProof.NavierStokesFlow.SecondQuant.fockCore_dense
import Mathlib
import Definitions.Def_ChapterNavierStokesSecondQuant
import Theorems.Thm_BookProof_NavierStokesFlow_SecondQuant_single_mem_fockCore
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.SecondQuant










open scoped ENNReal



variable {ι : Type*}
variable {S : ι → Type*} [∀ m, NormedAddCommGroup (S m)] [∀ m, InnerProductSpace ℂ (S m)]





variable (D : ∀ m, Submodule ℂ (S m))


variable {D}

set_option maxHeartbeats 1000000 in
theorem solution (hD : ∀ m, Dense ((D m : Submodule ℂ (S m)) : Set (S m))) :
    Dense ((fockCore D : Submodule ℂ (lp S 2)) : Set (lp S 2)) := by

  classical
  rw [Metric.dense_iff]
  intro f r hr
  -- first approximate `f` by a finite sector truncation
  have hsum := lp.hasSum_single (E := S) (p := 2) (by simp) f
  obtain ⟨s, hs⟩ :=
    (hsum.eventually (Metric.ball_mem_nhds f (by linarith : (0:ℝ) < r / 2))).exists
  -- then approximate each of the finitely many sector states from `D m`
  have hchoice : ∀ m : ι, ∃ y ∈ ((D m : Submodule ℂ (S m)) : Set (S m)),
      dist ((f : ∀ m, S m) m) y < r / (2 * ((s.card : ℝ) + 1)) := by
    intro m
    have hpos : 0 < r / (2 * ((s.card : ℝ) + 1)) := by positivity
    have hmem : (f : ∀ m, S m) m ∈ closure ((D m : Submodule ℂ (S m)) : Set (S m)) := by
      rw [(hD m).closure_eq]; trivial
    exact Metric.mem_closure_iff.mp hmem _ hpos
  choose y hyD hy using hchoice
  refine ⟨∑ m ∈ s, lp.single 2 m (y m), ?_, ?_⟩
  · -- the approximant is within `r` of `f`
    have hdiff : ‖(∑ m ∈ s, lp.single 2 m ((f : ∀ m, S m) m)) - ∑ m ∈ s, lp.single 2 m (y m)‖
        ≤ ∑ m ∈ s, ‖(f : ∀ m, S m) m - y m‖ := by
      rw [← Finset.sum_sub_distrib]
      refine (norm_sum_le _ _).trans (le_of_eq (Finset.sum_congr rfl fun m _ => ?_))
      rw [← lp.single_sub]
      exact lp.norm_single (by norm_num) m _
    have hbound : ∑ m ∈ s, ‖(f : ∀ m, S m) m - y m‖ < r / 2 := by
      have hlt : ∀ m ∈ s, ‖(f : ∀ m, S m) m - y m‖ ≤ r / (2 * ((s.card : ℝ) + 1)) := by
        intro m _
        have h := hy m
        rw [dist_eq_norm] at h
        exact h.le
      have hcalc : ∑ m ∈ s, ‖(f : ∀ m, S m) m - y m‖
          ≤ (s.card : ℝ) * (r / (2 * ((s.card : ℝ) + 1))) := by
        calc ∑ m ∈ s, ‖(f : ∀ m, S m) m - y m‖
            ≤ ∑ _m ∈ s, r / (2 * ((s.card : ℝ) + 1)) := Finset.sum_le_sum hlt
          _ = (s.card : ℝ) * (r / (2 * ((s.card : ℝ) + 1))) := by simp [mul_comm]
      have heq : (s.card : ℝ) * (r / (2 * ((s.card : ℝ) + 1)))
          = (r / 2) * ((s.card : ℝ) / ((s.card : ℝ) + 1)) := by
        have hc : ((s.card : ℝ) + 1) ≠ 0 := by positivity
        field_simp
      have hfrac : (s.card : ℝ) / ((s.card : ℝ) + 1) < 1 := by
        rw [div_lt_one (by positivity)]
        linarith
      have hlast : (s.card : ℝ) * (r / (2 * ((s.card : ℝ) + 1))) < r / 2 := by
        rw [heq]
        nlinarith [hr, hfrac]
      linarith
    have h1 : dist (∑ m ∈ s, lp.single 2 m ((f : ∀ m, S m) m)) f < r / 2 := hs
    have h2 : dist (∑ m ∈ s, lp.single 2 m (y m))
        (∑ m ∈ s, lp.single 2 m ((f : ∀ m, S m) m)) < r / 2 := by
      rw [dist_eq_norm, ← norm_neg]
      simpa using lt_of_le_of_lt hdiff hbound
    have htri := dist_triangle (∑ m ∈ s, lp.single 2 m (y m))
      (∑ m ∈ s, lp.single 2 m ((f : ∀ m, S m) m)) f
    simp only [Metric.mem_ball]
    linarith
  · -- and it lies in the finite-particle domain
    exact Submodule.sum_mem _ fun m _ => single_mem_fockCore m (y m) (hyD m)

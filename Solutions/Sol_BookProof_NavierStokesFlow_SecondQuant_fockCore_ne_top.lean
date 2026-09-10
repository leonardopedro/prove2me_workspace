-- Generated from ChapterNavierStokesSecondQuant.lean — solution of BookProof.NavierStokesFlow.SecondQuant.fockCore_ne_top
import Mathlib
import Definitions.Def_ChapterNavierStokesSecondQuant
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.SecondQuant










open scoped ENNReal



variable {ι : Type*}
variable {S : ι → Type*} [∀ m, NormedAddCommGroup (S m)] [∀ m, InnerProductSpace ℂ (S m)]





variable (D : ∀ m, Submodule ℂ (S m))


variable {D}

set_option maxHeartbeats 1000000 in
theorem solution {S : ℕ → Type*} [∀ m, NormedAddCommGroup (S m)]
    [∀ m, InnerProductSpace ℂ (S m)] (D : ∀ m, Submodule ℂ (S m))
    (v : ∀ m, S m) (hv : ∀ m, ‖v m‖ = 1) :
    (fockCore D : Submodule ℂ (lp S 2)) ≠ ⊤ := by

  intro htop
  set g : ∀ m, S m := fun m => ((1 : ℝ) / (m + 1) : ℝ) • v m with hg
  have hnorm : ∀ k : ℕ, ‖g k‖ = 1 / (k + 1) := by
    intro k
    have hpos : (0 : ℝ) ≤ 1 / ((k : ℝ) + 1) := by positivity
    simp only [hg, norm_smul, hv, Real.norm_eq_abs, mul_one]
    exact abs_of_nonneg hpos
  have hmem : Memℓp g 2 := by
    apply memℓp_gen
    have hcongr : ∀ k : ℕ, ‖g k‖ ^ (2 : ℝ≥0∞).toReal = (1 / ((k : ℝ) + 1)) ^ 2 := by
      intro k
      rw [hnorm k]
      norm_num
    rw [summable_congr hcongr]
    have hbase : Summable fun k : ℕ => (1 / ((k : ℝ)) ^ 2) :=
      Real.summable_one_div_nat_pow.mpr (by norm_num : 1 < 2)
    have := (summable_nat_add_iff (f := fun k : ℕ => (1 / ((k : ℝ)) ^ 2)) 1).mpr hbase
    refine this.congr fun k => ?_
    rw [div_pow]
    norm_num
  have hmemCore : (⟨g, hmem⟩ : lp S 2) ∈ fockCore D := by rw [htop]; trivial
  have hfin := hmemCore.1
  have hinf : ¬ (Function.support fun m => ‖g m‖).Finite := by
    intro hfin'
    have hsub : Set.univ ⊆ Function.support fun m => ‖g m‖ := by
      intro k _
      simp only [Function.mem_support, hnorm k]
      positivity
    exact Set.infinite_univ (hfin'.subset hsub)
  exact hinf hfin

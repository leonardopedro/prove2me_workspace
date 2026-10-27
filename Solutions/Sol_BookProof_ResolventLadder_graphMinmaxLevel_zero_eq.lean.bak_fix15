-- Generated from ChapterResolventMinMaxLadder.lean — solution of BookProof.ResolventLadder.graphMinmaxLevel_zero_eq
import Mathlib
import Definitions.Def_ChapterResolventMinMaxLadder
import Theorems.Thm_BookProof_ResolventLadder_res_mem
import Theorems.Thm_BookProof_ResolventLadder_graph_unique
import Theorems.Thm_BookProof_ResolventLadder_maxminLevel_zero_eq_sSup_rayleighSet
import Theorems.Thm_BookProof_ResolventLadder_rayleighSet_bddAbove
import Theorems.Thm_BookProof_ResolventLadder_graphRayleighSet_nonempty
import Theorems.Thm_BookProof_ResolventLadder_graphRayleighSet_bddAbove
import Theorems.Thm_BookProof_ResolventLadder_graphMinmaxSet_bddBelow
import Theorems.Thm_BookProof_ResolventLadder_graphMinmaxSet_nonempty
import Theorems.Thm_BookProof_ResolventLadder_resolvent_ladder_lower
import Theorems.Thm_BookProof_ResolventLadder_maxminLevel_zero_pos
import Theorems.Thm_BookProof_ChapterSirkRitzSpectrum_rayleighSet_nonempty
open BookProof.ResolventLadder



noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open BookProof.NonnegResolvent BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot BookProof.ClosureUniqueness
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution [Nontrivial F] (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) :
    graphMinmaxLevel T 0 = 1 / maxminLevel (res hT) 0 - 1 := by

  obtain ⟨x0, hx0⟩ := exists_ne (0 : F)
  have hne : (graphMinmaxSet T 0).Nonempty :=
    graphMinmaxSet_nonempty hT hsv (W := Submodule.span ℂ {x0})
      (by simpa using finrank_span_singleton hx0)
  refine le_antisymm ?_ (resolvent_ladder_lower hT hsv 0 hne)
  set ν := maxminLevel (res hT) 0 with hνdef
  have hνpos : 0 < ν := maxminLevel_zero_pos hT hsv
  refine le_of_forall_pos_le_add fun δ hδ => ?_
  -- pick a unit vector nearly maximizing the resolvent's Rayleigh quotient
  set ε : ℝ := min (ν / 2) (δ * ν ^ 2 / 2) with hεdef
  have hεpos : 0 < ε := lt_min (by linarith) (by positivity)
  have hεν : ε ≤ ν / 2 := min_le_left _ _
  have hεδ : ε ≤ δ * ν ^ 2 / 2 := min_le_right _ _
  have hsup : ν = sSup (rayleighSet (res hT)) := maxminLevel_zero_eq_sSup_rayleighSet (res hT)
  obtain ⟨t, ht, htlt⟩ : ∃ t ∈ rayleighSet (res hT), ν - ε < t := by
    refine exists_lt_of_lt_csSup (rayleighSet_nonempty (res hT)) ?_
    rw [← hsup]
    linarith
  obtain ⟨x, hx1, rfl⟩ := ht
  set A : ℝ := rayleighVal (res hT) x with hA
  have hAle : A ≤ ν := by
    rw [hsup]
    exact le_csSup (rayleighSet_bddAbove (res hT)) ⟨x, hx1, rfl⟩
  have hApos : 0 < A := by
    have : ν - ε < A := htlt
    linarith
  set y : F := res hT x with hy
  have hAle2 : A ≤ ‖y‖ := by
    calc A = (inner ℂ x y : ℂ).re := rfl
      _ ≤ ‖(inner ℂ x y : ℂ)‖ := Complex.re_le_norm _
      _ ≤ ‖x‖ * ‖y‖ := norm_inner_le_norm _ _
      _ = ‖y‖ := by rw [hx1, one_mul]
  have hypos : 0 < ‖y‖ := lt_of_lt_of_le hApos hAle2
  have hyne : y ≠ 0 := norm_pos_iff.mp hypos
  -- the line through `y` is a competitor
  have hmemT : (y, x - y) ∈ T := res_mem hT x
  have hdom : InDomain T (Submodule.span ℂ {y}) := by
    intro u hu
    obtain ⟨c, rfl⟩ := Submodule.mem_span_singleton.mp hu
    exact ⟨c • (x - y), T.smul_mem c hmemT⟩
  have hrank : Module.finrank ℂ (Submodule.span ℂ {y}) = 0 + 1 := by
    simpa using finrank_span_singleton hyne
  -- every Rayleigh value on that line equals `A/‖y‖² − 1`
  have hval : ∀ t ∈ graphRayleighSet T (Submodule.span ℂ {y}), t = A / ‖y‖ ^ 2 - 1 := by
    rintro t ⟨u, w, huw, huS, hu1, rfl⟩
    obtain ⟨c, rfl⟩ := Submodule.mem_span_singleton.mp huS
    have hw : w = c • (x - y) := graph_unique hsv huw (T.smul_mem c hmemT)
    have hc2 : ‖c‖ ^ 2 * ‖y‖ ^ 2 = 1 := by
      have : ‖c • y‖ = 1 := hu1
      rw [norm_smul] at this
      nlinarith [norm_nonneg c, norm_nonneg y]
    have hbase : (inner ℂ y (x - y) : ℂ).re = A - ‖y‖ ^ 2 := by
      rw [inner_sub_right, Complex.sub_re, inner_self_eq_norm_sq_to_K]
      have hyx : (inner ℂ y x : ℂ).re = A := by
        rw [hA, rayleighVal, ← hy, ← inner_conj_symm, Complex.conj_re]
      rw [hyx]
      norm_cast
    have hcc : (starRingEnd ℂ) c * c = ((‖c‖ ^ 2 : ℝ) : ℂ) := by
      rw [← Complex.normSq_eq_conj_mul_self, Complex.normSq_eq_norm_sq]
    have hexp : (inner ℂ (c • y) w : ℂ).re = ‖c‖ ^ 2 * (inner ℂ y (x - y) : ℂ).re := by
      rw [hw, inner_smul_left, inner_smul_right, ← mul_assoc, hcc, Complex.re_ofReal_mul]
    rw [hexp, hbase]
    field_simp
    nlinarith [hc2]
  have hbdd : BddAbove (graphRayleighSet T (Submodule.span ℂ {y})) := by
    have : FiniteDimensional ℂ (Submodule.span ℂ {y}) := .of_finrank_pos (by rw [hrank]; omega)
    exact graphRayleighSet_bddAbove hsv hdom
  have hsetne : (graphRayleighSet T (Submodule.span ℂ {y})).Nonempty :=
    graphRayleighSet_nonempty (by rw [hrank]; omega) hdom
  have hsupval : graphRayleighSup T (Submodule.span ℂ {y}) ≤ A / ‖y‖ ^ 2 - 1 :=
    csSup_le hsetne fun t ht => le_of_eq (hval t ht)
  have hlow : graphMinmaxLevel T 0 ≤ graphRayleighSup T (Submodule.span ℂ {y}) :=
    csInf_le (graphMinmaxSet_bddBelow hT 0) ⟨_, hrank, hdom, rfl⟩
  -- arithmetic: `A/‖y‖² ≤ 1/A ≤ 1/(ν − ε) ≤ 1/ν + δ`
  have h1 : A / ‖y‖ ^ 2 ≤ 1 / A := by
    rw [div_le_div_iff₀ (by positivity) hApos]
    nlinarith [hAle2, hApos]
  have hAeq : (inner ℂ x y : ℂ).re = A := rfl
  have h2 : 1 / A ≤ 1 / (ν - ε) := by
    have hνε : 0 < ν - ε := by linarith
    exact one_div_le_one_div_of_le hνε (by rw [← hAeq]; linarith [htlt])
  have h3 : 1 / (ν - ε) ≤ 1 / ν + δ := by
    have hνε : 0 < ν - ε := by linarith
    rw [div_add' _ _ _ (ne_of_gt hνpos), div_le_div_iff₀ hνε hνpos]
    nlinarith
  linarith

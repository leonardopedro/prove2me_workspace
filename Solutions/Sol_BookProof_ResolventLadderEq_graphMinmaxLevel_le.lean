-- Generated from ChapterResolventMinMaxEquality.lean — solution of BookProof.ResolventLadderEq.graphMinmaxLevel_le
import Mathlib
import Definitions.Def_ChapterResolventMinMaxEquality
import Theorems.Thm_BookProof_ResolventLadderEq_stepUp_continuous
import Theorems.Thm_BookProof_ResolventLadderEq_stepUp_eq_zero
import Theorems.Thm_BookProof_ResolventLadderEq_stepUp_eq_one
import Theorems.Thm_BookProof_ResolventLadderEq_stepUp_nonneg
import Theorems.Thm_BookProof_ResolventLadderEq_mul_rayleigh_le_normSq_of_mem_range
import Theorems.Thm_BookProof_ResolventLadderEq_rayleighVal_le_of_cfc_eq_zero
import Theorems.Thm_BookProof_ResolventLadderEq_exists_unit_mem_ker_of_no_range_subspace
import Theorems.Thm_BookProof_ResolventLadder_graphMinmaxSet_bddBelow
import Theorems.Thm_BookProof_ResolventLadder_graphRayleighSet_nonempty
import Theorems.Thm_BookProof_ResolventLadder_graph_unique
import Theorems.Thm_BookProof_ResolventLadder_rayleighSetOn_bddBelow
import Theorems.Thm_BookProof_ResolventLadder_res_injective
import Theorems.Thm_BookProof_ResolventLadder_res_isSelfAdjoint
import Theorems.Thm_BookProof_ResolventLadder_res_mem
open BookProof.ResolventLadderEq



noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum
open BookProof.ResolventLadder
open BookProof.NonnegResolvent BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot BookProof.ClosureUniqueness
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) (k : ℕ)
    (hne : (graphMinmaxSet T k).Nonempty)
    (hpos : 0 < maxminLevel (res hT) k) :
    graphMinmaxLevel T k ≤ 1 / maxminLevel (res hT) k - 1 := by

  classical
  set R : F →L[ℂ] F := res hT with hRdef
  set ν : ℝ := maxminLevel R k with hνdef
  have hRsa : IsSelfAdjoint R := res_isSelfAdjoint hT
  refine le_of_forall_pos_le_add fun η hη => ?_
  -- the parameters
  set ε : ℝ := min (ν / 3) (η * ν ^ 2 / 3) with hεdef
  have hεpos : 0 < ε := lt_min (by linarith) (by positivity)
  have hεν : ε ≤ ν / 3 := min_le_left _ _
  have hεη : ε ≤ η * ν ^ 2 / 3 := min_le_right _ _
  set c : ℝ := ν - ε with hcdef
  set δ : ℝ := ε / 2 with hδdef
  have hδpos : 0 < δ := by positivity
  have hc' : c - δ = ν - 3 * ε / 2 := by rw [hcdef, hδdef]; ring
  have hc'pos : 0 < c - δ := by rw [hc']; linarith
  have hcpos : 0 < c := by rw [hcdef]; linarith
  set q : ℝ → ℝ := stepUp c δ with hqdef
  have hqc : Continuous q := stepUp_continuous c δ
  have hq0 : ∀ t : ℝ, t ≤ c - δ → q t = 0 := fun t ht => stepUp_eq_zero hδpos ht
  have hq1 : ∀ t : ℝ, c ≤ t → q t = 1 := fun t ht => stepUp_eq_one hδpos ht
  have hqnn : ∀ t : ℝ, 0 ≤ q t := fun t => stepUp_nonneg c δ t
  set P : F →L[ℂ] F := cfc q R with hPdef
  by_cases hex : ∃ S₀ : Submodule ℂ F,
      Module.finrank ℂ S₀ = k + 1 ∧ (S₀ : Set F) ⊆ Set.range P
  · -- the spectral subspace above `c` is big enough: it supplies a competitor
    obtain ⟨S₀, hS₀rank, hS₀range⟩ := hex
    have hspec : ∀ μ ∈ spectrum ℝ R,
        (c - δ) * (μ * (q μ * q μ)) ≤ (μ * q μ) * (μ * q μ) := by
      intro μ _
      rcases eq_or_ne (q μ) 0 with h0 | h0
      · rw [h0]; ring_nf; rfl
      · have hμ : c - δ < μ := by
          by_contra hcon
          exact h0 (stepUp_eq_zero hδpos (by linarith [not_lt.mp hcon]))
        have hμ0 : 0 < μ := lt_trans hc'pos hμ
        have hsq : 0 ≤ q μ * q μ := mul_self_nonneg _
        nlinarith
    -- the competitor subspace inside the domain of `T`
    have hinjR : Function.Injective R := res_injective hT hsv
    have hmaprank : Module.finrank ℂ (S₀.map (R : F →ₗ[ℂ] F)) = k + 1 := by
      have hequiv : S₀ ≃ₗ[ℂ] (S₀.map (R : F →ₗ[ℂ] F)) :=
        Submodule.equivMapOfInjective _ hinjR S₀
      rw [← hequiv.finrank_eq, hS₀rank]
    have hdom : InDomain T (S₀.map (R : F →ₗ[ℂ] F)) := by
      rintro y hy
      obtain ⟨w, -, rfl⟩ := Submodule.mem_map.mp hy
      exact ⟨w - R w, res_mem hT w⟩
    have hvals : ∀ t ∈ graphRayleighSet T (S₀.map (R : F →ₗ[ℂ] F)), t ≤ 1 / (c - δ) - 1 := by
      rintro t ⟨y, z, hyz, hyS, hy1, rfl⟩
      obtain ⟨x, hxS₀, hxy⟩ := Submodule.mem_map.mp hyS
      have hy : R x = y := hxy
      have hz : z = x - y := by
        refine graph_unique hsv hyz ?_
        rw [← hy]
        exact res_mem hT x
      obtain ⟨w, hw⟩ := hS₀range hxS₀
      have hbound := mul_rayleigh_le_normSq_of_mem_range R hRsa q hqc (c - δ) hspec w
      rw [← hPdef, hw, hy, hy1] at hbound
      have hray : rayleighVal R x ≤ 1 / (c - δ) := by
        rw [le_div_iff₀ hc'pos]
        nlinarith [hbound]
      have hinner : (inner ℂ y z : ℂ).re = rayleighVal R x - 1 := by
        rw [hz, inner_sub_right, Complex.sub_re, inner_self_eq_norm_sq_to_K, hy1]
        have hyx : (inner ℂ y x : ℂ).re = rayleighVal R x := by
          rw [rayleighVal, ← hy, ← inner_conj_symm, Complex.conj_re]
        rw [hyx]
        norm_num
      rw [hinner]
      linarith
    have hsetne : (graphRayleighSet T (S₀.map (R : F →ₗ[ℂ] F))).Nonempty :=
      graphRayleighSet_nonempty (by rw [hmaprank]; omega) hdom
    have hsup : graphRayleighSup T (S₀.map (R : F →ₗ[ℂ] F)) ≤ 1 / (c - δ) - 1 :=
      csSup_le hsetne hvals
    have hlow : graphMinmaxLevel T k ≤ graphRayleighSup T (S₀.map (R : F →ₗ[ℂ] F)) :=
      csInf_le (graphMinmaxSet_bddBelow hT k) ⟨_, hmaprank, hdom, rfl⟩
    -- arithmetic: `1/(ν − 3ε/2) ≤ 1/ν + η`
    have harith : 1 / (c - δ) ≤ 1 / ν + η := by
      rw [hc', div_add' _ _ _ (ne_of_gt hpos), div_le_div_iff₀ (by rw [← hc']; exact hc'pos) hpos]
      nlinarith
    linarith
  · -- otherwise the resolvent's level would be at most `c`
    exfalso
    have hspec2 : ∀ μ ∈ spectrum ℝ R, μ ≤ c + μ * q μ := by
      intro μ _
      rcases le_or_gt μ c with hμ | hμ
      · have hnn : 0 ≤ μ * q μ := by
          rcases le_or_gt 0 μ with h | h
          · exact mul_nonneg h (hqnn μ)
          · rw [hq0 μ (by linarith), mul_zero]
        linarith
      · rw [hq1 μ hμ.le, mul_one]
        linarith
    have hle : ν ≤ c := by
      have hmaxne : (maxminSet R k).Nonempty := by
        obtain ⟨t, S, hrank, -, -⟩ := hne
        exact ⟨rayleighInfOn R S, S, hrank, rfl⟩
      refine csSup_le hmaxne ?_
      rintro t ⟨W, hWrank, rfl⟩
      obtain ⟨x, hxW, hx1, hx0⟩ :=
        exists_unit_mem_ker_of_no_range_subspace P hex hWrank
      have hx0' : cfc q R x = 0 := by rw [← hPdef]; exact hx0
      have hray := rayleighVal_le_of_cfc_eq_zero R hRsa q hqc c hspec2 hx0'
      rw [hx1] at hray
      refine csInf_le_of_le (rayleighSetOn_bddBelow R W) (b := rayleighVal R x)
        ⟨x, hxW, hx1, rfl⟩ ?_
      simpa using hray
    rw [hcdef] at hle
    linarith

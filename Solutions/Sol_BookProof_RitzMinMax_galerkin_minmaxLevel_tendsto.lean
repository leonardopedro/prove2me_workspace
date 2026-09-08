-- Generated from ChapterSirkRitzMinMax.lean — solution of BookProof.RitzMinMax.galerkin_minmaxLevel_tendsto
import Mathlib
import Definitions.Def_ChapterSirkRitzMinMax
import Theorems.Thm_BookProof_RitzMinMax_minmaxSetIn_bddBelow
import Theorems.Thm_BookProof_RitzMinMax_minmaxLevel_le_minmaxLevelIn
import Theorems.Thm_BookProof_RitzMinMax_exists_galerkin_approx_subspace
import Theorems.Thm_BookProof_RitzMinMax_minmaxSetIn_galerkin_nonempty
import Theorems.Thm_BookProof_RitzMinMax_minmaxSet_nonempty
open BookProof.RitzMinMax










noncomputable section


open BookProof.HermiteGalerkin BookProof.ChapterSirkRitzSpectrum
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (T : F →L[ℂ] F) (b : HilbertBasis ℕ ℂ F) (k : ℕ) :
    Tendsto (fun m : ℕ => minmaxLevelIn T (galerkinSpan b m) k) atTop
      (nhds (minmaxLevel T k)) := by

  rw [Metric.tendsto_atTop]
  intro ε hε
  obtain ⟨t, ht, htlt⟩ := exists_lt_of_csInf_lt (minmaxSet_nonempty T b k)
    (show minmaxLevel T k < minmaxLevel T k + ε / 2 by linarith)
  obtain ⟨S, hrank, rfl⟩ := ht
  obtain ⟨m₀, hm₀⟩ := exists_galerkin_approx_subspace T b hrank (half_pos hε)
  refine ⟨max m₀ (k + 1), fun m hm => ?_⟩
  have hlow : minmaxLevel T k ≤ minmaxLevelIn T (galerkinSpan b m) k :=
    minmaxLevel_le_minmaxLevelIn T _ k (minmaxSetIn_galerkin_nonempty T b (le_of_max_le_right hm))
  obtain ⟨S', hS'le, hS'rank, hS'sup⟩ := hm₀ m (le_of_max_le_left hm)
  have hup : minmaxLevelIn T (galerkinSpan b m) k ≤ rayleighSup T S' :=
    csInf_le (minmaxSetIn_bddBelow T _ k) ⟨S', hS'le, hS'rank, rfl⟩
  rw [Real.dist_eq, abs_lt]
  constructor <;> linarith

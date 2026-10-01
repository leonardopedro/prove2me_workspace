-- Generated from ChapterEsaClosureCore.lean — solution of BookProof.EsaClosure.clRange_isClosed
import Mathlib
import Definitions.Def_ChapterEsaClosureCore
import Theorems.Thm_BookProof_EsaClosure_clExt_symmetricOn
import Theorems.Thm_BookProof_EsaClosure_mem_clGraph_of_tendsto
import Theorems.Thm_BookProof_HashimotoShiftInvert_norm_cshiftMap_ge
open BookProof.EsaClosure



open Filter Topology


open BookProof.FarisLavine BookProof.HashimotoShiftInvert

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in

variable [CompleteSpace F]

theorem solution (T : D →ₗ[ℂ] F) (hdense : Dense (D : Set F)) (hsym : SymmetricOn D T)
    {γ : ℂ} (hγ : γ.im ≠ 0) :
    IsClosed ((cshiftRange (clExt T hdense hsym) γ :=
   : Submodule ℂ F) : Set F) := by
    have hpos : 0 < |γ.im| := abs_pos.mpr hγ
    set A := clExt T hdense hsym with hA
    refine IsSeqClosed.isClosed ?_
    intro u p hu hup
    choose x hx using hu
    have hcauchy : CauchySeq (fun n => ((x n : F))) := by
      have hucauchy : CauchySeq u := hup.cauchySeq
      rw [Metric.cauchySeq_iff] at hucauchy ⊢
      intro eps heps
      obtain ⟨N, hN⟩ := hucauchy (|γ.im| * eps) (by positivity)
      refine ⟨N, fun m hm n hn => ?_⟩
      have hb : |γ.im| * ‖((x m - x n : clDom T) : F)‖ ≤ ‖cshiftMap A γ (x m - x n)‖ :=
        norm_cshiftMap_ge (clExt_symmetricOn T hdense hsym) _ _
      rw [map_sub, hx m, hx n] at hb
      have hlt : ‖u m - u n‖ < |γ.im| * eps := by
        have hd := hN m hm n hn
        rwa [dist_eq_norm] at hd
      have hkey : |γ.im| * ‖((x m : F)) - ((x n : F))‖ < |γ.im| * eps := by
        refine lt_of_le_of_lt ?_ hlt
        simpa using hb
      rw [dist_eq_norm]
      exact lt_of_mul_lt_mul_left hkey hpos.le
    obtain ⟨w, hw⟩ := cauchySeq_tendsto_of_complete hcauchy
    have hAconv : Tendsto (fun n => clFun T (x n)) atTop (nhds (γ • w - p)) := by
      have hval : ∀ n, clFun T (x n) = γ • ((x n : F)) - u n := by
        intro n
        have hn := hx n
        simp only [cshiftMap_apply, hA, clExt_apply] at hn
        rw [← hn]; abel
      simp only [hval]
      exact (hw.const_smul γ).sub hup
    have hmem : (w, γ • w - p) ∈ clGraph T := mem_clGraph_of_tendsto hw hAconv
    have hwmem : w ∈ clDom T := mem_clDom_iff.2 ⟨_, hmem⟩
    refine ⟨⟨w, hwmem⟩, ?_⟩
    have hval : clFun T ⟨w, hwmem⟩ = γ • w - p := clFun_unique hdense hsym hmem
    simp only [cshiftMap_apply,

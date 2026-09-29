-- Generated from ChapterSirkTrotterKato.lean — solution of BookProof.ChapterSirkTrotterKato.hasDerivAt_duhamel
import Mathlib
import Definitions.Def_ChapterSirkTrotterKato
import Theorems.Thm_BookProof_ChapterSirkTrotterKato_hasDerivAt_stoneU_const_sub_apply
import Theorems.Thm_BookProof_ChapterSirkTrotterKato_resolvent_commutator_eq
import Theorems.Thm_BookProof_ChapterSirkTrotterKato_stoneU_shift
import Definitions.Def_ChapterStoneResolvent
open BookProof.ChapterSirkTrotterKato











noncomputable section

open Filter Topology Asymptotics
open scoped InnerProductSpace


open BookProof.ChapterStoneResolvent

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution (T S : UnboundedSelfAdjoint H) (chi : T.domain) (t u : ℝ) :
    HasDerivAt (fun r : ℝ => S.stoneU (t - r) (S.resCLM 1 (T.stoneU r (chi : H))))
      (Complex.I • S.stoneU (t - u)
        (T.resCLM 1 (T.stoneU u (T.shift 1 chi))
          - S.resCLM 1 (T.stoneU u (T.shift 1 chi)))) u := by

  set y : ℝ → H := fun r => S.resCLM 1 (T.stoneU r (chi : H)) with hy
  have hmem : y u ∈ S.domain := S.resCLM_mem 1 _
  have hderiv : HasDerivAt y
      (S.resCLM 1 ((-Complex.I) • T.op ⟨T.stoneU u (chi : H), T.stoneU_mem_domain u chi⟩)) u := by
    have h := T.hasDerivAt_stoneU_op chi u
    exact ((S.resCLM 1).restrictScalars ℝ).hasFDerivAt.comp_hasDerivAt u h
  have hprod := hasDerivAt_stoneU_const_sub_apply S hderiv hmem (t := t)
  refine hprod.congr_deriv ?_
  -- identify the two derivative values
  set z : T.domain := ⟨T.stoneU u (chi : H), T.stoneU_mem_domain u chi⟩ with hz
  have hop : S.op ⟨S.stoneU (t - u) (y u), S.stoneU_mem_domain (t - u) ⟨y u, hmem⟩⟩
      = S.stoneU (t - u) (S.op ⟨y u, hmem⟩) := S.stoneU_op (t - u) ⟨y u, hmem⟩
  have hsm : S.resCLM 1 ((-Complex.I) • T.op z) = (-Complex.I) • S.resCLM 1 (T.op z) := by
    rw [ContinuousLinearMap.map_smul]
  have hcomm : S.op ⟨y u, hmem⟩ - S.resCLM 1 (T.op z)
      = T.resCLM 1 (T.shift 1 z) - S.resCLM 1 (T.shift 1 z) :=
    resolvent_commutator_eq T S z
  have hshift : T.shift 1 z = T.stoneU u (T.shift 1 chi) := stoneU_shift T chi u
  rw [hop, hsm, ← hshift]
  rw [show (S.stoneU (t - u) ((-Complex.I) • S.resCLM 1 (T.op z)))
      = (-Complex.I) • S.stoneU (t - u) (S.resCLM 1 (T.op z)) from
    ContinuousLinearMap.map_smul _ _ _]
  rw [← hcomm, map_sub]
  module

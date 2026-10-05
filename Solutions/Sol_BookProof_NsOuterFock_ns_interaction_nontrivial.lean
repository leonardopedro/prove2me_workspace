-- Generated from ChapterNsOuterFockFarisLavine.lean — solution of BookProof.NsOuterFock.ns_interaction_nontrivial
import Mathlib
import Definitions.Def_ChapterNsOuterFockFarisLavine
import Theorems.Thm_BookProof_NsOuterFock_nsVec_coupling
import Theorems.Thm_BookProof_QgOuterFockInteractionFL_nextPart_ne
open BookProof.NsOuterFock




open Finset MvPolynomial
open BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.HermiteProductCore BookProof.QgHermiteOscillator
open BookProof.QgOuterFock BookProof.QgOuterFockFL
open BookProof.QgOuterFockInteractionFL
open BookProof.SqSumOuterFamily

noncomputable section

variable (bv : Fin 3 → ℝ) (nu lam mu gg : ℝ)

set_option maxHeartbeats 1000000 in
theorem solution {n : ℕ} (hn : 2 ≤ n) (hlam : lam ≠ 0) :
    ∃ (r : Fin n × NsLoc) (I : Fin (n * 18)),
      parcelOf I ≠ r.1 ∧ nsVec bv nu lam mu gg n r I ≠ 0 := by

  have hn0 : 0 < n := lt_of_lt_of_le (by norm_num) hn
  refine ⟨(⟨0, hn0⟩, locD 0 0), coordOf (nextPart ⟨0, hn0⟩) (locU 0), ?_, ?_⟩
  · rw [parcelOf_coordOf]
    exact nextPart_ne hn ⟨0, hn0⟩ rfl
  · rw [nsVec_coupling bv nu lam mu gg _ 0 0 (nextPart_ne hn ⟨0, hn0⟩ rfl)]
    simpa using hlam

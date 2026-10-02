-- Generated from ChapterQgTimeStepping.lean — solution of BookProof.QgTimeStepping.cnStep_second_order
import Mathlib
import Definitions.Def_ChapterQgTimeStepping
import Theorems.Thm_BookProof_QgTimeStepping_cnStep_apply
import Theorems.Thm_BookProof_QgTimeStepping_two_div_ne_zero
import Theorems.Thm_BookProof_QgTimeStepping_res_second_order




open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge

noncomputable section

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)

set_option maxHeartbeats 1000000 in
theorem solution {tau : ℝ} (htau : tau ≠ 0) (x : T.domain) (hx : T.op x ∈ T.domain) :
    cnStep T tau (x : H)
      = (x : H) - ((tau : ℂ) * Complex.I) • T.op x
        + ((tau : ℂ) * Complex.I)
            • ((T.res (2 / tau) (T.op ⟨T.op x, hx⟩) : T.domain) : H) := by

  have hl : (2 / tau : ℝ) ≠ 0 := two_div_ne_zero htau
  have hlC : ((2 / tau : ℝ) : ℂ) ≠ 0 := by exact_mod_cast hl
  have htauC : ((tau : ℝ) : ℂ) ≠ 0 := by exact_mod_cast htau
  rw [cnStep_apply, res_second_order T hl x hx]
  push_cast
  match_scalars
  all_goals field_simp
  all_goals ring_nf
  all_goals simp [Complex.I_sq]
  all_goals ring

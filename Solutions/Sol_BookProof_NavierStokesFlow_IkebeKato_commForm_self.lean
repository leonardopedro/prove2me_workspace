-- Generated from ChapterNavierStokesIkebeKato.lean — solution of BookProof.NavierStokesFlow.IkebeKato.commForm_self
import Mathlib
import Definitions.Def_ChapterNavierStokesIkebeKato
import Theorems.Thm_BookProof_FarisLavine_commForm_eq
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.IkebeKato



open scoped ENNReal



open LpNat FarisLavine

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
t, proved -/

theorem solution (c : ι → ℝ) (x : maxDom c) : commForm (diagMax c) (dia :=
  gMax c) x = 0 := by
    rw [commForm_eq]
    have him : (inner ℂ (diagMax c x) (diagMax c x) : ℂ).im = 0 := by
      simpa using inner_self_im (𝕜 := ℂ) ((diagMax c x))
    r

-- Generated from ChapterGaugeUnconstrainedSpectrum.lean — solution of BookProof.ChapterGaugeUnconstrainedSpectrum.shift_isPhysicalFunction_const
import Mathlib
import Definitions.Def_ChapterGaugeUnconstrainedSpectrum
open BookProof.ChapterGaugeUnconstrainedSpectrum




variable {X : Type*}

variable {X : Type*}
variable {G : Type*} [Group G]

set_option maxHeartbeats 1000000 in
theorem solution {d : ℤ → ℂ} (hd : IsPhysicalFunction shiftPerm d)
    (k l : ℤ) : d k = d l := by

  have h := hd (Multiplicative.ofAdd (l - k)) k
  simp only [shiftPerm_apply] at h
  rw [show k + Multiplicative.toAdd (Multiplicative.ofAdd (l - k)) = l from by
    change k + (l - k) = l; omega] at h
  exact h.symm

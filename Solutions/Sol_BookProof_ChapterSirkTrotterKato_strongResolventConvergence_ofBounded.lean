-- Generated from ChapterSirkTrotterKatoGalerkin.lean — solution of BookProof.ChapterSirkTrotterKato.strongResolventConvergence_ofBounded
import Mathlib
import Definitions.Def_ChapterSirkTrotterKatoGalerkin
import Theorems.Thm_BookProof_ChapterSirkTrotterKato_resCLM_ofBounded
import Definitions.Def_ChapterUnitaryTransport
import Definitions.Def_ChapterSirkTrotterKato
open BookProof.ChapterSirkTrotterKato









noncomputable section

open Filter Topology


open BookProof.ChapterStoneResolvent BookProof.ChapterUnitaryTransport

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution {A : ℕ → H →L[ℂ] H} {Alim : H →L[ℂ] H}
    (hA : ∀ n, IsSelfAdjoint (A n)) (hlim : IsSelfAdjoint Alim)
    (hconv : ∀ u : H, Tendsto (fun n => A n u) atTop (𝓝 (Alim u))) :
    StrongResolventConvergence (ofBounded Alim hlim) (fun n => ofBounded (A n) (hA n)) := by

  intro y
  have hz : (Complex.I).im ≠ 0 := by simp
  have h := BookProof.HermiteGalerkin.resolvent_tendsto_of_strong_tendsto A Alim hA hlim hz hconv y
  have h' := h.neg
  simp only [resCLM_ofBounded]
  exact h'

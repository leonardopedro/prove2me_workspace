-- Generated from ChapterSirkTrotterKatoGalerkin.lean — solution of BookProof.ChapterSirkTrotterKato.flow_tendsto_of_strong_tendsto
import Mathlib
import Definitions.Def_ChapterSirkTrotterKatoGalerkin
import Theorems.Thm_BookProof_ChapterSirkTrotterKato_strongResolventConvergence_ofBounded
open BookProof.ChapterSirkTrotterKato









noncomputable section

open Filter Topology


open BookProof.ChapterStoneResolvent BookProof.ChapterUnitaryTransport

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution {A : ℕ → H →L[ℂ] H} {Alim : H →L[ℂ] H}
    (hA : ∀ n, IsSelfAdjoint (A n)) (hlim : IsSelfAdjoint Alim)
    (hconv : ∀ u : H, Tendsto (fun n => A n u) atTop (𝓝 (Alim u))) (v : H) (t : ℝ) :
    Tendsto (fun n => (ofBounded (A n) (hA n)).stoneU t v) atTop
      (𝓝 ((ofBounded Alim hlim).stoneU t v)) := trotterKato_tendsto _ _ (strongResolventConvergence_ofBounded hA hlim hconv) v t

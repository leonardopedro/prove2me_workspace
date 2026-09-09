-- Generated from ChapterSirkTrotterKato.lean — theorem BookProof.ChapterSirkTrotterKato.tendsto_uniformly_on_isCompact_of_tendsto
import Mathlib
import Definitions.Def_ChapterSirkTrotterKato
open BookProof.ChapterSirkTrotterKato










noncomputable section

open Filter Topology Asymptotics
open scoped InnerProductSpace


open BookProof.ChapterStoneResolvent

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

theorem BookProof.ChapterSirkTrotterKato.tendsto_uniformly_on_isCompact_of_tendsto {D : ℕ → H →L[ℂ] H} {M : ℝ}
    (hM : ∀ n y, ‖D n y‖ ≤ M * ‖y‖) (hptw : ∀ y, Tendsto (fun n => D n y) atTop (𝓝 0))
    {K : Set H} (hK : IsCompact K) {ε : ℝ} (hε : 0 < ε) :
    ∀ᶠ n in atTop, ∀ y ∈ K, ‖D n y‖ ≤ ε := by sorry

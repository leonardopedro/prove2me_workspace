-- Generated from ChapterNavierStokesCanonicalVector.lean — solution of BookProof.NavierStokesFlow.CanonicalVector.hFun_eq_of_incoming
import Mathlib
import Definitions.Def_ChapterNavierStokesCanonicalVector
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.CanonicalVector



open scoped ENNReal



open LpNat FarisLavine IkebeKato ThreeComponent ShiftHamiltonian SignedShift

set_option maxHeartbeats 1000000 in
theorem solution {sym : Vel → ℝ} (S : SignedHop Vel sym) (X g : Vel → ℂ)
    (h1 : ∀ β, g (S.shift β) = (S.amp β : ℂ) * X β)
    (h2 : ∀ γ, (¬ ∃ α, S.shift α = γ) → g γ = 0) (γ : Vel) :
    S.hFun X γ = Complex.I * (g γ - (S.amp γ : ℂ) * X (S.shift γ)) := by

  have hkey : S.maj.hop (fun α => (S.amp α : ℂ) * X α) γ = g γ := by
    by_cases hb : ∃ α, S.shift α = γ
    · obtain ⟨α, rfl⟩ := hb
      have hs : S.maj.hop (fun α => (S.amp α : ℂ) * X α) (S.maj.shift α)
          = (S.amp α : ℂ) * X α := ShiftData.hop_shift _ _ _
      exact hs.trans (h1 α).symm
    · rw [ShiftData.hop_eq_zero _ _ hb, h2 γ hb]
  rw [SignedHop.hFun, hkey]

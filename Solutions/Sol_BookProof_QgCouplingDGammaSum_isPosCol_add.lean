-- Generated from ChapterQgCouplingDGammaSum.lean — solution of BookProof.QgCouplingDGammaSum.isPosCol_add
import Mathlib
import Definitions.Def_ChapterQgCouplingDGammaSum
open BookProof.QgCouplingDGammaSum




open BookProof.FockSecondQuantization
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs

noncomputable section

variable {ι : Type*}

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution {a b : ℕ → (ℕ →₀ ℂ)} (ha : IsPosCol a) (hb : IsPosCol b) :
    IsPosCol (fun k => a k + b k) := by

  intro S c
  have hsplit : (∑ j ∈ S, ∑ k ∈ S, (starRingEnd ℂ) (c j) * ((a k + b k) j) * c k)
      = (∑ j ∈ S, ∑ k ∈ S, (starRingEnd ℂ) (c j) * (a k) j * c k)
        + ∑ j ∈ S, ∑ k ∈ S, (starRingEnd ℂ) (c j) * (b k) j * c k := by
    rw [← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun k _ => ?_
    rw [Finsupp.add_apply]
    ring
  rw [hsplit, Complex.add_re]
  exact add_nonneg (ha S c) (hb S c)

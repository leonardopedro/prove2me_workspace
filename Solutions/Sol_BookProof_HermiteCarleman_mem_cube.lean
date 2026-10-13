-- Generated from ChapterHermiteCarlemanEsa.lean — solution of BookProof.HermiteCarleman.mem_cube
import Mathlib
import Definitions.Def_ChapterHermiteCarlemanEsa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterQuadratureEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
open BookProof.HermiteCarleman




open Finset MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.HyperbolicQuadratic
open BookProof.HermiteRelative
open BookProof.QuadratureEsa
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in

theorem solution {d N : ℕ} {a : Fin d →₀ ℕ} : a ∈ cube d N ↔ ∀ i, a i ≤ N := by
  classical
  constructor
  · intro h
    rw [cube, Finset.mem_image] at h
    obtain ⟨f, hf, rfl⟩ := h
    intro i
    have h2 := (Fintype.mem_piFinset.mp hf) i
    have h3 := Nat.lt_succ_iff.mp (Finset.mem_range.mp h2)
    simpa [Finsupp.equivFunOnFinite] using h3
  · intro h
    rw [cube, Finset.mem_image]
    exact ⟨Finsupp.equivFunOnFinite a, Fintype.mem_piFinset.mpr
      (fun i => Finset.mem_range.mpr (Nat.lt_succ_of_le (h i))), by simp⟩

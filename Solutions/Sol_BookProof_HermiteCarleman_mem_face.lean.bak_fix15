-- Generated from ChapterHermiteCarlemanEsa.lean — solution of BookProof.HermiteCarleman.mem_face
import Mathlib
import Definitions.Def_ChapterHermiteCarlemanEsa
import Theorems.Thm_BookProof_HermiteCarleman_mem_cube
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
theorem solution {d N : ℕ} {i : Fin d} {a : Fin d →₀ ℕ} :
    a ∈ face d N i ↔ (∀ j, a j ≤ N) ∧ a i = N := by

  classical
  rw [face, Finset.mem_filter, mem_cube]

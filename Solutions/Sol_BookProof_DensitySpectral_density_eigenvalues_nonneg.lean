-- Generated from ChapterDensitySpectral.lean — solution of BookProof.DensitySpectral.density_eigenvalues_nonneg
import Mathlib
import Definitions.Def_ChapterDensitySpectral
open BookProof.DensitySpectral




open Matrix
open scoped BigOperators ComplexOrder

variable {n : Type*} [Fintype n] [DecidableEq n]

variable {n : Type*} [Fintype n] [DecidableEq n]

set_option maxHeartbeats 1000000 in
theorem solution {ρ : Matrix n n ℂ} (h : IsDensityMatrix ρ) (i : n) :
    0 ≤ h.1.eigenvalues i := h.2.1.eigenvalues_nonneg i

-- Generated from ChapterNavierStokesCanonicalVector.lean — theorem BookProof.NavierStokesFlow.CanonicalVector.nsQuadraticH_essentiallySelfAdjointOn_core
import Mathlib
import Definitions.Def_ChapterNavierStokesCanonicalVector
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.CanonicalVector

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)


open scoped ENNReal



open LpNat FarisLavine IkebeKato ThreeComponent ShiftHamiltonian SignedShift

The quantized full quadratic Navier–Stokes symbol is essentially self-adjoint on the
Hermite core of the three velocity components**, for every viscosity, every velocity
gradient and every velocity Laplacian at the fiber. -/
theorem BookProof.NavierStokesFlow.CanonicalVector.nsQuadraticH_essentiallySelfAdjointOn_core
    (nu : ℝ) (grad : Matrix (Fin 3) (Fin 3) ℝ) (lap : Fin 3 → ℝ) :
    EssentiallySelfAdjointOn (lpFiniteModes Vel)
      ((lpFiniteModes Vel).subtype.comp (nsQuadraticH nu grad lap)) :=
  c := by sorry

-- Generated from ChapterFullQuadraticEsa.lean — solution of BookProof.FullQuadratic.polySym_fqPoly
import Mathlib
import Definitions.Def_ChapterFullQuadraticEsa
import Theorems.Thm_BookProof_FullQuadratic_polySym_fqQuadPoly
import Theorems.Thm_BookProof_YangMillsHermite_PolySym_add
open BookProof.FullQuadratic




open Finset MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.HyperbolicQuadratic
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (P Q S : Fin d → Fin d → ℝ) (b b' : Fin d → ℝ) :
    BookProof.YangMillsHermite.PolySym (fqPoly P Q S b b') := (polySym_fqQuadPoly P Q S).add (polySym_foPoly b b')

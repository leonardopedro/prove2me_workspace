-- Generated from ChapterShiftedQuadraticEsa.lean — solution of BookProof.ShiftedQuadratic.oscTPoly_eq
import Mathlib
import Definitions.Def_ChapterShiftedQuadraticEsa
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterShiftedHermiteCore
open BookProof.ShiftedQuadratic




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic
open BookProof.ShiftedHermiteCore
open BookProof.FarisLavine
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (a k : Vd d) (i : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    oscTPoly a k i p
      = momTPoly k i (momTPoly k i p) + (1/4 : ℂ) • (mulXTPoly a i (mulXTPoly a i p)) := by

  simp [oscTPoly]

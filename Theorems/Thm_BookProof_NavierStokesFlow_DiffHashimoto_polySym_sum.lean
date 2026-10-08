-- Generated from ChapterNavierStokesDiffHashimoto.lean — theorem BookProof.NavierStokesFlow.DiffHashimoto.polySym_sum
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Mathlib
import Definitions.Def_ChapterNavierStokesDiffHashimoto
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterSirkFinitePrecision
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.HermiteProductCore
open BookProof.SirkFinitePrecision
open BookProof.SirkFinitePrecision.CertInterval
open BookProof.YangMillsHermite
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.DiffHashimoto


open Filter Topology



open MvPolynomial
open BookProof.FarisLavine BookProof.HashimotoShiftInvert BookProof.EsaClosure
open BookProof.HermiteGalerkin
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteRelative
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)


theorem BookProof.NavierStokesFlow.DiffHashimoto.polySym_sum {d : ℕ} {ι : Type*} (s : Finset ι)
    (T : ι → Module.End ℂ (MvPolynomial (Fin d) ℂ))
    (hT : ∀ i ∈ s, BookProof.YangMillsHermite.PolySym (T i)) :
    BookProof.YangMillsHermite.PolySym (∑ i ∈ s, T i) := by sorry

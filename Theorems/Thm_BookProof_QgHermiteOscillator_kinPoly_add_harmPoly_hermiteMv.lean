-- Generated from ChapterQgHermiteOscillatorEsa.lean — theorem BookProof.QgHermiteOscillator.kinPoly_add_harmPoly_hermiteMv
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Definitions.Def_ChapterGaussCoreQuadBounds
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteFriedrichs
open BookProof.GaussCoreQuadBounds
open BookProof.HermiteProductBasis
open BookProof.HermiteProductCore
open BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator



open MeasureTheory Complex MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.FarisLavine
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
  {ι : Type*} {D : Submodule ℂ F}
variable {d : ℕ}

theorem BookProof.QgHermiteOscillator.kinPoly_add_harmPoly_hermiteMv (a : Fin d →₀ ℕ) :
    kinPoly (hermiteMv a) + harmPoly * hermiteMv a
      = (((mvDeg a : ℂ) + (d : ℂ) / 2)) • hermiteMv a := by sorry

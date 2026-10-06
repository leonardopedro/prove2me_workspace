-- Generated from ChapterQuantizationWeyl.lean — theorem BookProof.QuantizationWeyl.Heis_mul
import Mathlib
import Definitions.Def_ChapterQuantizationWeyl
open BookProof.QuantizationWeyl


open NormedSpace
open scoped Matrix


attribute [local instance] Matrix.linftyOpNormedRing Matrix.linftyOpNormedAlgebra

theorem BookProof.QuantizationWeyl.Heis_mul (a b c a' b' c' : ℝ) :
    Heis a b c * Heis a' b' c' = Heis (a + a') (b + b') (c + c' + a * b') := by sorry
